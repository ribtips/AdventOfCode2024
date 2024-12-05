#!/usr/bin/perl
#

use strict;
use warnings;

my @a=();
my @b=();

&main;

sub main {
    &read_file($ARGV[0]);
    &similarity;
}

sub similarity {
    my $total=0;
    foreach my $val (@a) {
        my $instance = scalar(grep {$_ == $val} @b);
        $total+=$val * $instance;
    }
    print "Total is: $total\n";

}

sub sort_and_subtract {
    my @sorted_A=sort {$a <=> $b} @a;
    my @sorted_B=sort {$a <=> $b} @b;
    my $inc=0;
    my $total=0;
    foreach my $item (@sorted_A) {
        $total+=abs($sorted_A[$inc]-$sorted_B[$inc]);
        $inc++;
    }
    print "Total is: $total\n";
}

sub read_file {
    my $file=shift;
    open(my $fh,$file);
    foreach my $line (<$fh>) {
        chomp($line);
        my ($a,$b)=split/\s+/,$line;
        push @a,$a;
        push @b,$b;
    }
    close($fh);
}
