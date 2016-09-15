#! /usr/bin/perl

use warnings;
use strict;

use BLAST2;
use GO2;
use Report;
use Matrix2;

# Hash to store gene-to-description mappings
# my %geneToDescription;

printReport();

# Load the transcript IDs and protein IDs from the BLAST output to a hash for lookup.
sub readBlast {
    print "Entering ReadBlast\n";
    my $blastFile    = "/scratch/RNASeq/blastp.outfmt6";
    
    # Open a filehandle for the BLAST file.
    open(BLAST_FILE, "<", $blastFile) or die $!;
    
    # Hash to store BLAST mappings
    my %transcriptToProtein;
    
    while (<BLAST_FILE>) {
        # Remove end-of-line characters
        chomp;
        
        my %temp = ();
	    $temp{'blastLine'} = $_;
	
        my $blast = BLAST2->new(\%temp);
        
        if ($blast->has_transcriptId() && $blast->get_pident() > 99 && not defined $transcriptToProtein{$blast->get_transcriptId()}) {
            $transcriptToProtein{$blast->get_transcriptId()} = $blast;
        }
    }
    
    print "Exiting ReadBlast\n";
    
    return \%transcriptToProtein;
}

# Load the protein IDs and corresponding GO terms to a hash for lookup.
sub readGeneToGO {
    print "Entering ReadGeneToGo\n";
    
    my $geneToGoFile = "/scratch/gene_association.goa_uniprot";
    #my $geneToGoFile = '/home/vadali.s/BIOL6200/Module04/goa_uniprot';
    
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
            my $goObj = "NA";
            if (defined $goDesc->{$GO_ID}) {
                $goObj = $goDesc->{$GO_ID};
            }
            $geneToGo{$DB_Object_ID}{$GO_ID} = $goObj // 'NA';
        }
    }
    
    print "Exiting ReadGeneToGo\n";
    
    return \%geneToGo;
}

# Load the GO terms and GO descriptions to a hash for lookup.
sub readGoDesc {
    print "Entering ReadGoDesc\n";
    
    local $/ = "[Term]";
    
    my $goDescFile   = "/scratch/go-basic.obo";
    
    # Open a filehandle for the GO_DESC file.
    open(GO_DESC, "<", $goDescFile) or die $!;

    my %goDesc;

    # Read the gene-to-description file line-by-line
    while (<GO_DESC>) {

        # Remove end-of-line characters
        chomp;
        my %temp = ();
	    $temp{'longGoDesc'} = $_;
	
        my $go = GO2->new(\%temp);
        if ($go->has_id()) {
            $goDesc{$go->get_id()} = $go;
        }
    }

    print "Exiting ReadGoDesc\n";
    
    return \%goDesc;
}

# Loop through the differential expression file, and lookup the protein ID, GO term, GO term description, 
#and SwissProt protein description then print the output.
sub printReport {
    print "Entering PrintReport\n";
    
    my $diffExpFile  = "/scratch/RNASeq/diffExpr.P1e-3_C2.matrix";
    
    # Open a filehandle for the CUFFDIFF file.
    open(DIFF_EXP, "<", $diffExpFile) or die $!;
    
    my $geneToGo = readGeneToGO();
    my $transcriptToProtein = readBlast();
    
    my %args = (reportFile => 'report.txt', geneToGo => $geneToGo, transcriptToProtein => $transcriptToProtein);
    my $report = Report->new(\%args);
    
    while ( <DIFF_EXP> ) {
        my $line = $_;
        
        my %args = (matrixLine => $line);
        my $matrix = Matrix2->new(\%args);
        
        my %temp = ('matrixObj' => $matrix);
        
        if (defined $matrix && $matrix->has_Sp_ds()) {
            $report->printLine(\%temp);
            #$report->printLine($matrix);
        }
    }
    
    print "Exiting PrintReport\n";
}
