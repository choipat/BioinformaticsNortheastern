#!/usr/bin/perl
use warnings;
use strict;

use Report;

use Test::More;

#Intialize the $_ to prevent warnings i redefinition of $/ as RegEx
$_ = '';

my %geneToGo = ('key' => 'value');
my %transcriptToProtein = ('key' => 'value');

my %args = (reportFile => "", geneToGo => \%geneToGo, transcriptToProtein => \%transcriptToProtein);
my $report = Report->new(\%args);

ok( $report->has_reportFile());
ok( $report->has_geneToGo());
ok( $report->has_transcriptToProtein());

done_testing();