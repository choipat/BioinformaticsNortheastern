#!/usr/bin/perl
use warnings;
use strict;
use BLAST;

my $blastMappingsRef = readBlast();
#Loop through GO terms
foreach my $transcript ( keys $blastMappingsRef ) {
    #Call the printAll() function on the object
    $blastMappingsRef->{$transcript}->printAll();
}

sub readBlast {
    my $blastFile = "/scratch/RNASeq/blastp.outfmt6";
    
    # Open a filehandle for the BLAST file.
    open( BLAST_HANDLE, "<", $blastFile ) or die $!;
  
    # Hash to store BLAST mappings
    # Hash to store gene to GO term descriptions
    my %blastMappings = ();
    
    #Load the transcript IDs and protein IDs from the BLAST output to a hash for lookup.
    while (<BLAST_HANDLE>) {
        # Remove end-of-line characters
        chomp;

        # parse the record using a regular expression
        my $statement=$_;
        
        #Create a new bOBJ
        my $bObj = BLAST->new();

        #Call the parseBlastLine function on the object
        $bObj->parseBlastLine($statement);
        
        if ( defined $bObj->transcript() ) {
            # Add this new object to hash.
            $blastMappings{$bObj->transcript()} = $bObj;
        }
    }
    return \%blastMappings;
}    