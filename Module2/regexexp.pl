#!/usr/bin/perl
use strict;
use warnings;

#id: GO:0003733
#name: ribonucleoprotein
#namespace: molecular_function
#def: "OBSOLETE (was not defined before being made obsolete)." [GOC:mah]

my $namevar = "id: GO:0003733
name: mitochondrion inheritance";
my $id ="id: GO:0003733";
my $namespacevar = "id: GO:0003733
name: ribonucleoprotein
namespace: molecular_function"; # molecular_function";

if ($namevar =~ qr/^name:\s+(\D+\w+)/x ) {
    #print "$1\n";
}

if ($namevar =~ qr/name:\s+(?<name>\D+\w+)/x ) {
    #print "$+name\n";
}


if ($id =~ qr/^id:\s+(GO:\w+)/) {
    #print "$1\n";
}

if ($namespacevar =~ qr/^namespace:\s+(\w+)/msx) {
    #print "[$namespacevar]\n";
    #print "$1\n";
} else {
    print"namespace not done\n";
}

my $defvar = '[Term]
id: GO:0002641
name: negative regulation of immunoglobulin biosynthetic process
namespace: biological_process
def: "Any process that stops, prevents, or reduces the frequency, rate, or extent of immunoglobulin biosynthesis." [GOC:add]
synonym: "down regulation of immunoglobulin biosynthetic process" EXACT []
synonym: "down-regulation of immunoglobulin biosynthetic process" EXACT []
synonym: "downregulation of immunoglobulin biosynthetic process" EXACT []
synonym: "inhibition of immunoglobulin biosynthetic process" NARROW []
is_a: GO:0002640 ! regulation of immunoglobulin biosynthetic process
is_a: GO:0010558 ! negative regulation of macromolecule biosynthetic process
relationship: negatively_regulates GO:0002378 ! immunoglobulin biosynthetic process';

if ($defvar =~ qr/^def:\s+"(?<def>.*\.)\"\s+\S+/msx) {
    print $+{def}, "\n";
}

#$defvar = 'name: alpha-1,6-mannosyltransferase activity';

if ($defvar =~ qr/name:\s+(?<name>.*)\s+\S+/x) {
    #print $+{name}, "\n";
}


if ($defvar =~ qr/name:\s+(?<name>\D+\w+)/x ) {
    #print $+{name};
}
    
print "u" x 10;
