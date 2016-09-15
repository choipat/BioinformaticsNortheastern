#! /usr/bin/perl

use warnings;
use strict;

# Hash to store gene-to-description mappings
# my %geneToDescription;

printReport();

# Load the transcript IDs and protein IDs from the BLAST output to a hash for lookup.
sub readBlast {
    my $blastFile    = "/scratch/RNASeq/blastp.outfmt6";
    
    # Open a filehandle for the BLAST file.
    open(BLAST, "<", $blastFile) or die $!;
    
    # Hash to store BLAST mappings
    my %transcriptToProtein;
    
    while (<BLAST>) {
        # Remove end-of-line characters
        chomp;

        # Split the line on tabs and assign results
        # to named variables.
        my($qseqid, $sseqid, $pident, $length, $mismatch, $gapopen,
           $qstart, $qend, $sstart, $send, $evalue, $bitscore) = split(/\t/, $_);
        my($transcriptId, $isoform) = split(/\|/, $qseqid);
        my($giType, $gi, $swissProtType, $swissProtId, $proteinId) = split(/\|/, $sseqid);
        my($swissProtBase, $swissProtVersion) = split(/\./, $swissProtId);
        if ($pident > 99) {
            if (not defined $transcriptToProtein{$transcriptId}) {
                $transcriptToProtein{$transcriptId} = $swissProtBase;
            }
        }
    }
    
    return \%transcriptToProtein;
}

# Load the protein IDs and corresponding GO terms to a hash for lookup.
sub readGeneToGO {
    my $geneToGoFile = "/scratch/gene_association.goa_uniprot";
    
    # Open a filehandle for the gene ID to GO Term.
    open(GENE_TO_GO, "<", $geneToGoFile) or die $!;

    # Hash to store gene to GO term descriptions
    my $goDesc = readGoDesc();
    
    # Hash to store gene to GO term mappings
    my %geneToGo;
    
    while (<GENE_TO_GO>) {
        # Remove end - of - line characters
        chomp;
        my($DB, $DB_Object_ID, $DB_Object_Symbol, $Qualifier, $GO_ID) = split("\t", $_);

        # Make sure there is something in element 1 of the array
        # before using it as the key to a hash.
        if(defined $DB_Object_ID && defined $GO_ID) {
            my $GO_Desc = "NA";
            if (defined $goDesc->{$GO_ID}) {
                $GO_Desc = $goDesc->{$GO_ID};
            }
            $geneToGo{$DB_Object_ID}{$GO_ID} = $GO_Desc // 'NA';
        }
    }
    
    return \%geneToGo;
}

# Load the GO terms and GO descriptions to a hash for lookup.
sub readGoDesc {
    local $/ = "[Term]";
    
    my $goDescFile   = "/scratch/go-basic.obo";
    
    # Open a filehandle for the GO_DESC file.
    open(GO_DESC, "<", $goDescFile) or die $!;

    my %goDesc;
    
    # Read the gene-to-description file line-by-line
    while (<GO_DESC>) {

        # Remove end-of-line characters
        chomp;

        # Split the line on tabs and assign results
        # to an array.
        my $longGoDesc = $_;
        my @fields = split("\n", $_);
        my $id;
        my $name;
        foreach my $field (@fields) {
            my @keyValuePair = split( ": ", $field );
            if ( defined $keyValuePair[0] ) {
                if ( $keyValuePair[0] =~ /id$/) {
                    $id = $keyValuePair[1];
                }
                elsif ( $keyValuePair[0] =~ /name$/ ) {
                    $name = $keyValuePair[1];
                }
            }
            
            # Break when id and name fields are found and set.
            # This is to fix the bug in original code i.e we are overriding id with alternate id.
            if ($name && $id) {
                last;
            }
        }
        
        if ($name && $id) {
            $goDesc{$id} = $name;
        }
    }
    
    return \%goDesc;
}

# Loop through the differential expression file, and lookup the protein ID, GO term, GO term description, 
#and SwissProt protein description then print the output.
sub printReport {
    my $diffExpFile  = "/scratch/RNASeq/diffExpr.P1e-3_C2.matrix";
    my $reportFile   = "report.txt";
    
    # Open a filehandle for the CUFFDIFF file.
    open(DIFF_EXP, "<", $diffExpFile) or die $!;
    
    # Open a filehandle to write the report.
    open(REPORT, ">", $reportFile) or die $!;
    
    my $geneToGo = readGeneToGO();
    my $transcriptToProtein = readBlast();
    
    while ( <DIFF_EXP> ) {
        my($Sp_ds, $Sp_hs, $Sp_log, $Sp_plat) = split(/\t/, $_);
        my $proteinId = "NA";
        my $GO_ID = "NA";
        my $GO_Desc = "NA";
        my $proteinDesc = "NA";

        # Lookup protein ID.
        if(defined $transcriptToProtein->{$Sp_ds}) {
            $proteinId = $transcriptToProtein->{$Sp_ds};
            $proteinDesc = getProteinInfoFromBlastDb($proteinId);

            # Lookup GO Term.
            if(defined $geneToGo->{$proteinId}) {
            # Initialize a counter for number of GO terms associated with this protein.
                my $GO_ID_Count = 0;
                foreach my $GO_ID (keys $geneToGo->{$proteinId}) {
                    $GO_Desc = $geneToGo->{$proteinId} -> {$GO_ID};
                    # Increment the GO term counter
                    $GO_ID_Count++;
                    # Check if this is the first GO term for the protein.
                    if($GO_ID_Count == 1) {
                       # This is the first GO term, so print every field
                        my $line = join("\t", $Sp_ds, $Sp_hs, $Sp_log, $Sp_plat,
                                              $proteinId, $GO_ID, $GO_Desc, $proteinDesc);
                        print REPORT $line, "\n";
                    } else {
                        # This isn 't the first GO term, so just printthe GO term information.
                        # Put spaces for the other fields.
                        my $line = join("\t", ' ', ' ', ' ', ' ', '', $GO_ID, $GO_Desc);
                        print REPORT $line, "\n";
                    }
                }
            }
        }
    }
}

#Get the protein description from BLAST DB.
sub getProteinInfoFromBlastDb {
    my ($proteinId) = @_;
    my $db          = 'nr';
    my $exec        = "blastdbcmd -db " . $db
      . " -entry "
      . $proteinId
      . ' -outfmt "%t" -target_only | ';
    unless (open( SYSCALL, $exec )) {
        die "Can't open the SYSCALL ", $!;
    }
    my $proteinDescription = 'NA';
    while (<SYSCALL>) {
        chomp;
        if ($_ =~ /RecName:\s+(.*)/i) {
            $proteinDescription = $1;
        }
    }
    close SYSCALL;
    return $proteinDescription;
}