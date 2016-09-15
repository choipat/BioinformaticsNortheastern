#! /usr/bin/perl
use warnings;
use strict;

my $geneToGoFile = "/scratch/gene_association.goa_uniprot";
my $blastFile    = "/scratch/RNASeq/blastp.outfmt6";
my $diffExpFile  = "/scratch/RNASeq/diffExpr.P1e-3_C2.matrix";
my $goDescFile   = "/scratch/go-basic.obo";
my $reportFile   = "report.txt";
my $goDescShort  = "goDesc.txt";

# Open a filehandle to write the report.
open( DEBUG_FILE, ">", "./debugOut.log" ) or die $!;

debugPrint("Opening files\n");

# Open a filehandle for the gene ID to GO Term.
open( GENE_TO_GO, "<", $geneToGoFile ) or die $!;

# Open a filehandle for the BLAST file.
open( BLAST, "<", $blastFile ) or die $!;

# Open a filehandle for the CUFFDIFF file.
open( DIFF_EXP, "<", $diffExpFile ) or die $!;

# Open a filehandle for the GO_DESC file.
open( GO_DESC, "<", $goDescFile ) or die $!;

# Open a filehandle to write the report.
open( REPORT, ">", $reportFile ) or die $!;

debugPrint("Successfully opened files.\n");

# Hash to store gene-to-description mappings
my %geneToDescription;

# Hash to store gene to GO term mappings
my %geneToGo;

# Hash to store gene to GO term descriptions
my %goDesc;

# Hash to store BLAST mappings
my %transcriptToProtein;

readBlast();
readGeneToGO();
readGoDesc();
printReport();

close DEBUG_FILE;

#Load the transcript IDs and protein IDs from the BLAST output to a hash for lookup.
sub readBlast {
	debugPrint("Entering readBlast\n");
	
	while (<BLAST>) {
        # Remove end-of-line characters
		chomp;

		# Split the line on tabs and assign results
		# to named variables.
		my (
			$qseqid, $sseqid, $pident, $length, $mismatch, $gapopen,
			$qstart, $qend,   $sstart, $send,   $evalue,   $bitscore
		  )
		  = split( /\t/, $_ );
		my ( $transcriptId, $isoform ) = split( /\|/, $qseqid );
		my ( $giType, $gi, $swissProtType, $swissProtId, $proteinId ) =
		  split( /\|/, $sseqid );
		my ( $swissProtBase, $swissProtVersion ) =
		  split( /\./, $swissProtId );
		$transcriptToProtein{$transcriptId} = $swissProtBase;
		
		debugPrint("$transcriptId -> $swissProtBase\n");
	}
	
	debugPrint("Exiting readBlast\n");
}

#Load the protein IDs and corresponding GO terms to a hash for lookup.
sub readGeneToGO {
	while (<GENE_TO_GO>) {

		# Remove end-of-line characters
		chomp;
		my ( $DB, $DB_Object_ID, $DB_Object_Symbol, $Qualifier, $GO_ID ) =
		  split( "\t", $_ );

		# Make sure there is something in element 1 of the array
		# before using it as the key to a hash.
		if ( defined $DB_Object_ID && defined $GO_ID ) {

			# Put the gene ID and GO term in the hash with
			# both acting as keys to create a multi-dimensional hash.
			# There can be more than one GO term per gene, but the
			# mapping file also lists some GO terms twice. To store
			# multiple GO terms per gene without storing duplicates,
			# use a hash of hashes.
			if ( not defined $geneToGo{$DB_Object_ID} ) {
				$geneToGo{$DB_Object_ID} = $GO_ID;
			}
			
			#debugPrint("$DB_Object_ID \t $GO_ID\n");
		}
	}
}

#Load the GO terms and GO descriptions to a hash for lookup.
sub readGoDesc {
	local $/ = "[Term]";

    my $x = 0;
    
	# Read the gene-to-description file line-by-line
	while (<GO_DESC>) {

		# Remove end-of-line characters
		chomp;

		# Split the line on tabs and assign results
		# to an array.
		my $longGoDesc = $_;
		my @fields = split( "\n", $_ );
		my $id;
		my $name;
		foreach my $field (@fields) {
			my @keyValuePair = split( ": ", $field );
			if ( defined $keyValuePair[0] ) {
				if ( $keyValuePair[0] =~ /id$/) {
					$id = $keyValuePair[1];
					if ($x == 1) {
						debugPrint("id is $id");
					}
				}
				elsif ( $keyValuePair[0] =~ /name$/ ) {
					$name = $keyValuePair[1];
				}
			}
			
			# Break when id and name fields are found and set.
			# This is to fix the bug in original code i.e we are overriding id with alternate id.
			if ( $name && $id ) {
				last;
			}
		}
		
		if ($x == 1) {
			debugPrint("$longGoDesc");
			debugPrint("$id -> $name \n");
			$x = 0;
		}
		
		if ( $name && $id ) {
			$goDesc{$id} = $name;
		}
		
		# Use previous GO id (GO:0003673) to print set $x to 1 so that we can print long
		# description for required GO.
		if ($id && $id eq "GO:0003673") {
			$x = 1;
		}
	}

}

#Loop through the differential expression file, and lookup the protein ID, GO term, GO term description,
#and SwissProt protein description then print the output.
sub printReport {
	while (<DIFF_EXP>) {
		my ( $Sp_ds, $Sp_hs, $Sp_log, $Sp_plat ) = split( /\t/, $_ );
		my $proteinId   = "NA";
		my $GO_ID       = "NA";
		my $GO_Desc     = "NA";
		my $proteinDesc = "NA";

		#Lookup protein ID.
		if ( defined $transcriptToProtein{$Sp_ds} ) {
			$proteinId   = $transcriptToProtein{$Sp_ds};
			$proteinDesc = getProteinInfoFromBlastDb($proteinId);

			#Lookup GO Term.
			if ( defined $geneToGo{$proteinId} ) {
				$GO_ID = $geneToGo{$proteinId};

				#Lookup GO term description.
				if ( defined $goDesc{$GO_ID} ) {
					$GO_Desc = $goDesc{$GO_ID};
				}
			}
		}
		my $line = join( "\t",
			$Sp_ds, $proteinId, $GO_ID, $Sp_hs, $Sp_log, $Sp_plat, $GO_Desc,
			$proteinDesc );
		print REPORT $line, "\n";
	}
}

#Get the protein description from BLAST DB.
sub getProteinInfoFromBlastDb {
	my ($proteinId) = @_;
	my $db          = 'nr';
	my $exec        =
	    "blastdbcmd -db " . $db
	  . " -entry "
	  . $proteinId
	  . ' -outfmt "%t" -target_only | ';
	unless ( open( SYSCALL, $exec ) ) {
		die "Can't open the SYSCALL ", $!;
	}
	my $proteinDescription = 'NA';
	while (<SYSCALL>) {
		chomp;
		if ( $_ =~ /RecName:\s+(.*)/i ) {
			$proteinDescription = $1;
		}
	}
	close SYSCALL;
	return $proteinDescription;
}

sub debugPrint {
	my ($msg) = @_;
	print DEBUG_FILE $msg;
}