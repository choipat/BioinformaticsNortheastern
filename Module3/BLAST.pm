package BLAST;
use Moose;

sub printAll {
    my ($self) = @_;
    
    print $self->transcript(), "\t";
    print $self->isoform(), "\t";
    print $self->gi(), "\t";
    print $self->sp(), "\t";
    print $self->prot(), "\t";
    print $self->pident(), "\t";
    print $self->length(), "\t";
    print $self->mismatch(), "\t";
    print $self->gapopen(), "\t";
    print "\n";
}

#This subroutine parses a record from RNASeq/blastp.outfmt6
sub parseBlastLine {
    #Get the $self parameter and the record to parse statement
    my ($self, $statement) = @_;

    # Parse statement
    if ($statement =~ qr/^(?<transcript>c\w+\d+)\|/) {
        $self->transcript($+{transcript});
    }
    
    if ($statement =~ qr/\|(?<isoform>m.\d+)\s+/x) {
        $self->isoform($+{isoform});
    }

    if ($statement =~ qr/\|?\s+\w+\|(?<gi>\d+)\|/x) {
        $self->gi($+{gi});
    }

    if ($statement =~ qr/\|?\s+\w+\|\d+\|\w+\|(?<sp>.*)\|/x) {
        $self->sp($+{sp});
    }
    
    if ($statement =~ qr/\|?\s+\w+\|\d+\|\w+\|.*\|(?<prot>\w+)\t/x) {
        $self->prot($+{prot});
        my $prot = $+{prot};
    
        if ($statement =~ qr/.*\|$prot\s+(?<pident>\d+\.\d+)\s+/x) {
            $self->pident($+{pident});
            my $pident = $+{pident};
            if ($statement =~ qr/.*$pident\s+(?<length>\d+)\s+/x) {
                $self->length($+{length});
                            
                my $length = $+{length};
                if ($statement =~ qr/.*$pident\s+$length\s+(?<mismatch>\d+)\s+/x) {
                    $self->mismatch($+{mismatch});
                                    
                    my $mismatch = $+{mismatch};
                    if ($statement =~ qr/.*$pident\s+$length\s+$mismatch\s+(?<gapopen>\d+)\s+/x) {
                        $self->gapopen($+{gapopen});
                    }
                }        
            }
        }
    }
}

has 'transcript' => (
    is => 'rw',
    isa => 'Str'
);    

has 'isoform' => (
    is => 'rw',
    isa => 'Str'
);

has 'gi' => (
    is => 'rw',
    isa => 'Int'
);

has 'sp' => (
    is => 'rw',
    isa => 'Str'
);

has 'prot' => (
    is => 'rw',
    isa => 'Str'
);

has 'pident' => (
    is => 'rw',
    isa => 'Num'
);

has 'length' => (
    is => 'rw',
    isa => 'Int'
);

has 'mismatch' => (
    is => 'rw',
    isa => 'Int'
);

has 'gapopen' => (
    is => 'rw',
    isa => 'Int'
);

1;
