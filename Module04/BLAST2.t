#!/usr/bin/perl
use warnings;
use strict;

use BLAST2;

use MooseX::FollowPBP;

#use Test::More tests => 90;
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
    my $statement = $_;
    
    #Create a new blast object -bOBJ
    my %args = (blastLine => $statement);
    my $bObj = BLAST2->new(\%args);
    
    #OK is a test function that prints ok if the test is true 
    #and not OK if the test is false
    
    #Make sure the transcriptId is defined 
    ok( $bObj->has_transcriptId());
    
    #Make sure the isoform is defined 
    ok( $bObj->has_isoform());
    
    #Make sure the gi is defined 
    ok( $bObj->has_gi());
    
    #Make sure the pident is defined 
    ok( $bObj->has_pident());
    
    #Make sure the length is defined 
    ok( $bObj->has_len());
    
    #Make sure the mismatch is defined 
    ok(  $bObj->has_mismatch());
    
    #Make sure the gapopen is defined 
    ok(  $bObj->has_gapopen());
}

#Indicate the tests are done 
done_testing();

__END__
c0_g1_i1|m.1	gi|74665200|sp|Q9HGP0.1|PVG4_SCHPO	100.00	372	0	0	1	372	1	372	0.0	  754
c1000_g1_i1|m.799	gi|48474761|sp|O94288.1|NOC3_SCHPO	100.00	747	0	0	5	751	1	747	0.0	 1506
c1001_g1_i1|m.800	gi|259016383|sp|O42919.3|RT26A_SCHPO	100.00	268	0	0	1	268	1	268	0.0	  557
c1002_g1_i1|m.801	gi|1723464|sp|Q10302.1|YD49_SCHPO	100.00	646	0	0	1	646	1	646	0.0	 1310
c1003_g1_i1|m.803	gi|74631197|sp|Q6BDR8.1|NSE4_SCHPO	100.00	246	0	0	1	246	1	246	1e-179	  502
c1004_g1_i1|m.804	gi|74676184|sp|O94325.1|PEX5_SCHPO	100.00	598	0	0	1	598	1	598	0.0	 1227
c1005_g1_i1|m.805	gi|9910811|sp|O42832.2|SPB1_SCHPO	100.00	802	0	0	1	802	1	802	0.0	 1644
c1006_g1_i1|m.806	gi|74627042|sp|O94631.1|MRM1_SCHPO	100.00	255	0	0	1	255	47	301	0.0	  525
c1007_g1_i1|m.807	gi|20137702|sp|O74370.1|ISY1_SCHPO	100.00	201	0	0	1	201	1	201	4e-146	  412
c1008_g1_i1|m.808	gi|3023676|sp|P56287.1|EI2BE_SCHPO	100.00	678	0	0	6	683	1	678	0.0	 1408