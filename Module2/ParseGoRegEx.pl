#!/usr/bin/perl
use warnings;
use strict;
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
		}
		else {
			print STDERR $longGoDesc, "\n";
		}
	}
	return \%goDesc;
}
