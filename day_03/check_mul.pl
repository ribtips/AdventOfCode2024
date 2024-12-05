#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    open(my $fh,$ARGV[0]);
    my $val=0;
    foreach my $line (<$fh>) {
        $val+=&calculate($line);
    }
    close($fh);
    print "Total val:$val\n";
}

sub calculate {
    my $line=shift;
    my $val=0;
    while ($line=~m/mul\(([0-9]{1,3})\,([0-9]{1,3})\)/gc) {
        $val+=$1*$2;
    }
    print "Line: $val\n";
    return($val);
}
