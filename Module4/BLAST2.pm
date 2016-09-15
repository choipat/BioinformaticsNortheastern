package BLAST;
use Moose;
use MooseX::FollowPBP;

#accepts a line of BLAST output
sub BUILD {
	my($self, $args) = @_;
	
	# Split the line on tabs and assign results
	# to named variables.
	my (
		$qseqid, $sseqid, $pident, $length, $mismatch, $gapopen,
		$qstart, $qend,   $sstart, $send,   $evalue,   $bitscore	
	  )
	  = split( /\t/, $blastLine );
	my ( $transcript, $isoform ) = split( /\|/, $qseqid );
	my ( $giType, $gi, $swissProtType, $swissProtId, $proteinId ) =
	  split( /\|/, $sseqid );
	
	#set object variables
	$self->{transcript} = $transcript;
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

#prints all the BLAST fields in tab-separated format
sub printAll{
	my ($self) = @_;
	print $self->transcript(), "\t";
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

has 'transcript' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_transcript',
    predicate => 'has_transcript',
);    

has 'isoform' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_isoform',
    predicate => 'has_isoform',
);

has 'gi' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_gi',
    predicate => 'has_gi',
);

has 'sp' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_sp',
    predicate => 'has_sp',
);

has 'prot' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_prot',
    predicate => 'has_prot',
);

has 'pident' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_prot',
    predicate => 'has_prot',
);

has 'length' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_length',
    predicate => 'has_length',
);

has 'mismatch' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_mismatch',
    predicate => 'has_mismatch',
);

has 'gapopen' => (
    is => 'ro',
    isa => 'Int',
    clearer => 'clear_gapopen',
    predicate => 'has_gapopen',
);

1;
