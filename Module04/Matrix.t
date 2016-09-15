#!/usr/bin/perl
use warnings;
use strict;

use Matrix2;
use MooseX::FollowPBP;

use Test::More;

#Intialize the $_ to prevent warnings i redefinition of $/ as RegEx
$_ = '';

#Read the test dadat line by line .DATA is a special file handle for testing.
#It reads everything below __END__ as an input file.This special 
#filehandle allows test scripts to be created with thier own bulit in.

#test data
while (<DATA>) {
    
    #Remove end of line characters
    chomp;
    
    #parse the record using a regular expression
    my $line = $_;
    
    my %args = ('matrixLine' => $line);
    #Create a new matrix object -mOBJ
    my $mObj = Matrix2->new(\%args);
    
    #OK is a test function that prints ok if the test is true 
    #and not OK if the test is false
    
    #Make sure the Sp_ds is defined 
    ok( $mObj->has_Sp_ds());
    ok( defined $mObj->get_Sp_ds());
    
    #Make sure the Sp_hs is defined 
    ok( $mObj->has_Sp_hs());
    
    #Make sure the Sp_log is defined 
    ok( $mObj->has_Sp_log());
    
    #Make sure the Sp_plat is defined 
    ok( $mObj->has_Sp_plat());
}

#Indicate the tests are done 
done_testing();

__END__
c3833_g1_i2	4.00	0.07	16.84	26.37
c4832_g1_i1	24.55	116.87	220.53	28.82
c5161_g1_i1	107.49	89.39	26.95	698.97
c4399_g1_i2	27.91	72.57	5.56	36.58
c5916_g1_i1	82.57	19.03	48.55	258.22
c73_g1_i1	109.25	0.00	1.69	249.04
c2672_g1_i1	26.55	88.25	296.03	20.74
c4859_g1_i1	863.50	8798.74	2081.02	53.46