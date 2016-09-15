#!/usr/bin/perl
use warnings;
use strict;
use BLAST;
use MooseX::FollowPBP;

sub printReport {
   # my $diffExpFile  = "/scratch/RNASeq/diffExpr.P1e-3_C2.matrix";
    #my $reportFile   = "report.txt";
    
    # Open a filehandle for the CUFFDIFF file.
    #open(DIFF_EXP, "<", $diffExpFile) or die $!;
    
    # Open a filehandle to write the report.
    #open(REPORT, ">", $reportFile) or die $!;
     my($self, $args) = @_;
        
    my $diffExp = $args->{'diffExp'};
    
    #my $geneToGo = readGeneToGO();
    #my $transcriptToProtein = readBlast();
    
    #while ( <DIFF_EXP> ) {
        my($Sp_ds, $Sp_hs, $Sp_log, $Sp_plat) = split(/\t/, $_);
        my $proteinId = "NA";
        my $GO_ID = "NA";
        my $GO_Desc = "NA";
        my $proteinDesc = "NA";

=begin comment
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
=cut