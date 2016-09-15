#!/usr/bin/perl
use strict;
use warnings;
use Bio::Seq;
use Bio::SeqIO;


# File  :BioPerlScript1.pl
#Creates a Bio::Seq object and Bio::SeqIO class to write it to genbank format.

#create the seq object

my $seqObj = Bio::Seq->new(-seq => "aaaagggcctt",
                           -display_id => "12345",
                           -desc => "example 1",
                           -alphabet => "dna");
my $seqOutObj = Bio::SeqIO->new                          