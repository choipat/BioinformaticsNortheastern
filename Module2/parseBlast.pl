#!/usr/bin/perl
use warnings;
use strict;
use BLAST;
use autobox;


readBlast();

sub readBlast {
	my $blastFile = "/scratch/RNASeq/blastp.outfmt6";

    
    my $reportFile   = "parseBlastreport.txt";
    
    # Open a filehandle for the BLAST file.
    open( BLAST, "<", $blastFile ) or die $!;
  
    # Hash to store BLAST mappings
    my %transcriptToProtein;
	
    #Load the transcript IDs and protein IDs from the BLAST output to a hash for lookup.
    while (<BLAST>) {
        # Remove end-of-line characters
		chomp;

		# parse the record using a regular expression
		my $statement=$_;
		
		#Create a new bObj object
		my $bObj = BLAST->new();
		
		#Call the parseBlastLine function on the object
		$bObj->parseBlastLine($statement);
		
    }
    return \%transcriptToProtein;
}    