package GO;
use Moose;

has 'id' => (
      is => 'rw',
      isa => 'Str',
      );
has 'name' => (
     is => 'rw',
     isa => 'Str',
     );
has 'namespace' => (
     is =>'rw',
     isa => 'Str',
     );
has 'def' => (
     is =>'rw',
     isa => 'Str',
     );
has 'is_a' => (
    is => 'rw',
    isa => 'ArrayRef',
    );
has 'alt_id' => (
    is => 'rw',
    isa => 'ArrayRef'
);

sub fromGoBasic {
    my ( $self, $longGoDesc ) = @_;
    
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
                print $+{id}, "\n";
            }
            
            if ($longGoDesc =~ /$findName/) {
                print $+{name}, "\n";
            }
            
            if ($longGoDesc =~ /$findNamespace/) {
                print $+{namespace}, "\n";
            }
            
            if ($longGoDesc =~ /$findDef/) {
                if (not defined $+{def}) {
                    print STDERR $longGoDesc, "\n";
                }
                print $+{def}, "\n";
            }
	
			print "\nalt_ids:\n";
			my @alt_ids = ();
			while ( $longGoDesc =~ /$findAltId/g ) {
				push( @alt_ids, $+{alt_id} ); #push the alt_id onto @alt_ids
			}
			if (@alt_ids) {
				print join( ",", @alt_ids ), "\n";
			}
			print "\nisa:\n";
			my @isas = ();
			while ( $longGoDesc =~ /$findIsa/g ) {
				push( @isas, $+{isa} );
			}
			print join( ",", @isas ), "\n\n";
			
			# Create new object
			if (defined $+{id}) {
                 $self->id($+{id});
                 $self->name($+{name});
                 $self->namespace($+{namespace});
                 $self->def($+{def});
                 $self->alt_ids(@alt_ids);
                 $self->is_a(@isas);
        	}
            
		}
    }
}

1;
