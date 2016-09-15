package Matrix2;

use Moose;
use MooseX::FollowPBP;

sub BUILD {
    my($self, $args) = @_;
        
    my $matrixLine = $args->{'matrixLine'};
    
    # Split passed line
    my($Sp_ds, $Sp_hs, $Sp_log, $Sp_plat) = split(/\t/, $matrixLine);
    
    $self->{Sp_ds} = ($Sp_ds);
    $self->{Sp_hs} = $Sp_hs;
    $self->{Sp_log} = $Sp_log;
    $self->{Sp_plat} = $Sp_plat;
}

has 'Sp_ds' => (
    is => 'ro',
    isa => 'StrRef',
    clearer => 'clear_Sp_ds',
    predicate => 'has_Sp_ds',
);

has 'Sp_hs' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_Sp_hs',
    predicate => 'has_Sp_hs',
);

has 'Sp_log' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_Sp_log',
    predicate => 'has_Sp_log',
);

has 'Sp_plat' => (
    is => 'ro',
    isa => 'Num',
    clearer => 'clear_Sp_plat',
    predicate => 'has_Sp_plat',
);

1;