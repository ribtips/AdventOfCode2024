#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my %rules=();
my @updates=();

&main;

sub main {
    my $file=$ARGV[0];
    &read_in($file);
    &check_it;
    print Dumper %rules;

}

sub check_it {
    foreach my $update (@updates) {
        my @order=split/,/,$update;
        for(my $i=0;$i<scalar(@order);$i++) {
            my $num=$order[$i];
            print "checking $num\n";

        }
    }
}

sub read_in {
    my $file=shift;
    open(my $fh,$file);
    foreach my $line (<$fh>) {
        chomp($line);
        if ($line =~ /\|/) {
            my ($first,$second)=split/\|/,$line;
            push @{$rules{'after'}{$first}},$second;
            push @{$rules{'before'}{$second}},$first;
        }
        if ($line =~ /,/) {
            push @updates,$line;
        }
    }
    close($fh);
}
