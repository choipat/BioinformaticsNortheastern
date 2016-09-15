package BLAST2;

use Moose;

use MooseX::FollowPBP;

#prints all the BLAST fields in tab-separated format
sub printAll{
    my ($self) = @_;
    print $self->transcriptId(), "\t";
    print $self->isoform(), "\t";
    print $self->gi(), "\t";
    print $self->proteinId(), "\t";
    print $self->swissProtId(), "\t";
    print $self->pident(), "\t";
    print $self->len(), "\t";
    print $self->mismatch(), "\t";
    print $self->gapopen(), "\t";
    print $self->qstart(), "\t";
    print $self->qend(), "\t";
    print $self->sstart(), "\t";
    print $self->ssend(), "\t";
    print $self->evalue(), "\t";
    print $self->bitscore(), "\n";
}

sub BUILD {
    my($self, $args) = @_;
        
    my $blastLine = $args->{'blastLine'};
    
    # Split the line on tabs and assign results
    # to named variables.
    my (
        $qseqid, $sseqid, $pident, $length, $mismatch, $gapopen,
        $qstart, $qend,   $sstart, $send,   $evalue,   $bitscore    
      )
      = split( /\t/, $blastLine );
    my ( $transcriptId, $isoform ) = split( /\|/, $qseqid );
    my ( $giType, $gi, $swissProtType, $swissProtId, $proteinId ) =
      split( /\|/, $sseqid );
    
    #set object variables as hash references
    $self->{transcriptId} = $transcriptId;
    $self->{isoform} = $isoform;
    $self->{gi} = $gi;
    $self->{proteinId} = $proteinId;
    $self->{swissProtId} = $swissProtId;  
    $self->{pident} = $pident;
    $self->{len} = $length;
    $self->{mismatch} = $mismatch;
    $self->{gapopen} = $gapopen;
    $self->{qstart} = $qstart;
    $self->{qend} = $qend;
    $self->{sstart} = $sstart;
    $self->{ssend} = $send;
    $self->{evalue} = $evalue;
    $self->{bitscore} = $bitscore;    
}


has 'transcriptId' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_transcriptId',
    predicate => 'has_transcriptId',
);

has 'isoform' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_isoform',
    predicate => 'has_isoform'
);

has 'gi' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_gi',
    predicate => 'has_gi'
);

has 'swissProtId' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_swissProtId',
    predicate => 'has_swissProtId'
);

has 'proteinId' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_proteinId',
    predicate => 'has_proteinId'
);

has 'pident' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_pident',
    predicate => 'has_pident'
);

has 'len' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_len',
    predicate => 'has_len'
);

has 'gapopen' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_gapopen',
    predicate => 'has_gapopen'
);

has 'qstart' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_qstart',
    predicate => 'has_qstart'
);

has 'qend' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_qend',
    predicate => 'has_qend'
);

has 'sstart' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_sstart',
    predicate => 'has_sstart'
);

has 'mismatch' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_mismatch',
    predicate => 'has_mismatch'
);

has 'ssend' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_ssend',
    predicate => 'has_ssend'
);

has 'evalue' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_evalue',
    predicate => 'has_evalue'
);

has 'bitscore' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_bitscore',
    predicate => 'has_bitscore'
);

1;
