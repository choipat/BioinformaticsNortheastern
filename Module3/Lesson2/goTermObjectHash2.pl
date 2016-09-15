#!/usr/bin/perl
use warnings;
use strict;

use GO;

readGoDesc();

sub readGoDesc {
	my $goDescFile = "/scratch/go-basic.obo";

	# Open a filehandle for the GO_DESC file.
	open( GO_DESC, "<", $goDescFile ) or die $!;

	# Hash to store gene to GO term descriptions
	my %goDesc;
	local $/ = /[Term]|[Typedef]/;

	# Read the gene-to-description file line-by-line
	while (<GO_DESC>) {

		# Remove end-of-line characters
		chomp;

		# parse the record using a regular expression
		my $longGoDesc       = $_;
		#Regex to get id, name, namespace , and def. Use qr
		#as shown in Modern Perl. Use the modifier that allows whitespace and comments
		#in the regular expression. Use named captures. 
		
		my $go = GO -> new();
		$go->fromGoBasic($longGoDesc);
		if (defined $go->id()) {
		    $goDesc{$go->id()} = $go;
		}
	}
	return \%goDesc;
}
