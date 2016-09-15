package Report;

use Moose;
use MooseX::FollowPBP;

use Matrix2;

sub BUILD {
    my($self, $args) = @_;
        
    $self->{reportFile} = $args->{'reportFile'};
    
    $self->{geneToGo} = $args->{'geneToGo'};
    $self->{transcriptToProtein} = $args->{'transcriptToProtein'};
}

# Prints a line to report file for given Matrix object.
sub printLine {
    my($self, $args) = @_;
    
    my $matrix = $args->{matrixObj};
    
    # Open a filehandle to write the report.
    open(REPORT, ">", $self->{reportFile}) or die $!;
    
    if ($matrix->has_Sp_ds()) {
        # Lookup protein ID.
        my $transcriptToProteinHash = $self->{transcriptToProtein};
        
        my $blast = $transcriptToProteinHash->{$matrix->get_Sp_ds()};
        print "Transcrt id : ", $blast->get_transcriptId(), "\n";
        if($blast->has_transcriptId()) {
            my $proteinId = $blast->get_proteinId();
            my $proteinDesc = getProteinInfoFromBlastDb($proteinId);

            # Lookup GO Term.
            my $geneToGo = $self->{geneToGo}->{$proteinId};
            if(defined $geneToGo) {
                my $line = '';
                # Initialize a counter for number of GO terms associated with this protein.
                my $GO_ID_Count = 0;
                foreach my $GO_ID (keys $geneToGo->{$proteinId}) {
                    my $goObj = $geneToGo->{$proteinId}->{$GO_ID};
                    
                    my $GO_Desc = $goObj->get_name();
                    # Increment the GO term counter
                    $GO_ID_Count++;
                    # Check if this is the first GO term for the protein.
                    if($GO_ID_Count == 1) {
                       # This is the first GO term, so print every field
                        #my $line = join("\t", $Sp_ds, $Sp_hs, $Sp_log, $Sp_plat, $proteinId, $GO_ID, $GO_Desc, $proteinDesc);
                        print REPORT $line, "\n";
                    } else {
                        # This isn 't the first GO term, so just printthe GO term information.
                        # Put spaces for the other fields.
                        #my $line = join("\t", ' ', ' ', ' ', ' ', '', $GO_ID, $GO_Desc);
                        print REPORT $line, "\n";
                    }
                }
            }
        } else {
            print "Matrix is not defined \n";
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

has 'reportFile' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_reportFile',
    predicate => 'has_reportFile',
);

has 'geneToGo' => (
    is => 'ro',
    isa => 'HashRef',
    predicate => 'has_geneToGo'
);

has 'transcriptToProtein' => (
    is => 'ro',
    isa => 'HashRef',
    predicate => 'has_transcriptToProtein'
);

1;