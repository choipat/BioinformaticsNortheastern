#!/usr/bin/perl
use warnings;
use strict;

my $statement = "c1000_g1_i1|m.799  gi|48474761|sp|O94288.1|NOC3_SCHPO	100.00	747	0	2	5	751	1	747	0.0	1506";


if ($statement =~ qr/^(?<transcript>c\w+\d+)\|/) {
	print $+{transcript}, "\n";
}

if ($statement =~ qr/\|(?<isoform>m.\d+)\s+/x) {
    print $+{isoform}, "\n";
}

if ($statement =~ qr/\|?\s+\w+\|(?<gi>\d+)\|/x) {
    print $+{gi}, "\n";
}

if ($statement =~ qr/\|?\s+\w+\|\d+\|\w+\|(?<sp>.*)\|/x) {
    print $+{sp}, "\n";
}

if ($statement =~ qr/\|?\s+\w+\|\d+\|\w+\|.*\|(?<prot>\w+)\t/x) {
    print $+{prot}, "\n";
    my $prot = $+{prot};
    
    if ($statement =~ qr/.*\|$prot\s+(?<pident>\d+\.\d+)\s+/x) {
        print $+{pident}, "\n";
        my $pident = $+{pident};
        if ($statement =~ qr/.*$pident\s+(?<length>\d+)\s+/x) {
            print $+{length}, "\n";
            
            my $length = $+{length};
            if ($statement =~ qr/.*$pident\s+$length\s+(?<mismatch>\d+)\s+/x) {
                print $+{mismatch}, "\n";
                
                my $mismatch = $+{mismatch};
                if ($statement =~ qr/.*$pident\s+$length\s+$mismatch\s+(?<gapopen>\d+)\s+/x) {
                    print $+{gapopen}, "\n";
                    #gapopen 
                }
            }        
        }
    }
}
