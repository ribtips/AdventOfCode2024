#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    open(my $fh,$ARGV[0]);
    #my $data=do{local $/=undef;<$fh>};
    my $val=0;
    foreach my $data (<$fh>) {
        $val+=&calculate($data);
    }
    close($fh);
    print "Total val:$val\n";
}

sub calculate {
    my $line=shift;
    my $val=0;
    while ($line=~m/(don\'t\(\).*?do\(\))/gc) {
        #print "Got rid of $1\n";   
    }
    $line=~s/(don\'t\(\).*do\(\))?//g;
    while ($line=~m/mul\(([0-9]{1,3})\,([0-9]{1,3})\)/gc) {
        $val+=$1*$2;
    }
    print "Val: $val\n";
    return($val);
}
