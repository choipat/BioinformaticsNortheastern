#!/usr/bin/perl
use warnings;
use strict;

use GO2;

use Test::More;

#Intialize the $_ to prevent warnings i redefinition of $/ as RegEx
#$_ = '';

#Read the test dadat line by line .DATA is a special file handle for testing.
#It reads everything below __END__ as an input file.This special 
#filehandle allows test scripts to be created with thier own bulit in.

local $/ = "[Term]";

#test data
while (<DATA>) {
    
    #Remove end of line characters
    chomp;
    
    my $longGoDesc = $_;
    
    if (defined $longGoDesc && $longGoDesc ne "") {
        #parse the record using a regular expression
        
        #Create a new blast object -bOBJ
        my %args = ('longGoDesc' => $longGoDesc);
        my $gObj = GO2->new(\%args);
       
        #OK is a test function that prints ok if the test is true 
        #and not OK if the test is false
        
        #Make sure the id is defined 
        ok( $gObj->has_id());
        
        #Make sure the name is defined 
        ok( $gObj->has_name());
        
        #Make sure the namespace is defined 
        ok( $gObj->has_namespace());
        
        #Make sure the def is defined 
        ok( $gObj->has_def());
        
        #Make sure the is_a is defined 
        ok( $gObj->has_is_a());
        
        #Make sure the alt_ids is defined 
        ok( $gObj->has_alt_ids());
    }
}

#Indicate the tests are done 
done_testing();

__END__
[Term]
id: GO:0000001
name: mitochondrion inheritance
namespace: biological_process
def: "The distribution of mitochondria, including the mitochondrial genome, into daughter cells after mitosis or meiosis, mediated by interactions between mitochondria and the cytoskeleton." [GOC:mcc, PMID:10873824, PMID:11389764]
synonym: "mitochondrial inheritance" EXACT []
is_a: GO:0048308 ! organelle inheritance
is_a: GO:0048311 ! mitochondrion distribution
alt_id: GO:0019952
alt_id: GO:0050876

[Term]
id: GO:0000002
name: mitochondrial genome maintenance
namespace: biological_process
def: "The maintenance of the structure and integrity of the mitochondrial genome; includes replication and segregation of the mitochondrial chromosome." [GOC:ai, GOC:vw]
is_a: GO:0007005 ! mitochondrion organization
alt_id: GO:0019952
alt_id: GO:0050876