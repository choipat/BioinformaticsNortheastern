package GO;
use Moose;
use MooseX::FollowPBP;



sub BUILD {
    my ( $self, $args ) = @_;
    
    my $longGoDesc = $args->{'longGoDesc'};
    
    if ( $longGoDesc =~ /\[Term\]/ ) {
        #Regex to get the id
		my $findId = qr/
		^id:\s+(?<id>GO:\w+)
		/msx;
		
		#Regex to get the name
		my $findName = qr/
		name:\s+(?<name>.*)\s+\S+
		/x;
		
		#Regex to get the namespace
		my $findNamespace = qr/
		^namespace:\s+(?<namespace>\w+)
		/msx;
		
		#Regex to get the def
		my $findDef = qr/
		^def:\s+"(?<def>.*\.)\"\s+\S+
		/msx;
		
		#Regex to get all is_a Go Terms
		my $findIsa = qr/
		^is_a:\s+(?<isa>.*?)\s+!
		/msx;
		
		#Regex to get all alt_id Go Terms
		my $findAltId = qr/
		^alt_id:\s+(?<alt_id>.*?)\s+
		/msx;

        if ($longGoDesc =~ /$findId/) {
            if ($longGoDesc =~ /$findId/) {
                $self->{id} = $+id;
            }
            
            if ($longGoDesc =~ /$findName/) {
                $self->{name} = $+{name};
            }
            
            if ($longGoDesc =~ /$findNamespace/) {
                $self->{namespace} = $+{namespace};
            }
            
            if ($longGoDesc =~ /$findDef/) {
                $self->{def} = $+{def};
            }
	
			print "\nalt_ids:\n";
			my @alt_ids = ();
			while ( $longGoDesc =~ /$findAltId/g ) {
				push( @alt_ids, $+{alt_id} ); #push the alt_id onto @alt_ids
			}
			
			if (@alt_ids) {
				$self->{alt_ids} = @alt_ids;
			}
			
			my @isas = ();
			while ( $longGoDesc =~ /$findIsa/g ) {
				push( @isas, $+{isa} );
			}
            $self->{is_a} = @isas;
        }
    }
}

1;

has 'id' => (
    is => 'ro',
    isa => 'Str',
    clearer => 'clear_id',
    predicate => 'has_id',
);

has 'name' => (
     is => 'ro',
     isa => 'Str',
      clearer => 'clear_name',
      predicate => 'has_name',
     );
has 'namespace' => (
     is =>'ro',
     isa => 'Str',
      clearer => 'clear_namespace',
      predicate => 'has_namespace',
     );
has 'def' => (
     is =>'ro',
     isa => 'Str',
     clearer => 'clear_def',
     predicate => 'has_def',
     );
has 'is_a' => (
    is => 'ro',
    isa => 'ArrayRef',
    clearer => 'clear_is_a',
    predicate => 'has_is_a',
    );
has 'alt_ids' => (
    is => 'ro',
    isa => 'ArrayRef',
    clearer => 'clear_alt_ids',
    predicate => 'has_alt_ids',
);