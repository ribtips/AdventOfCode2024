#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my %data=();
my $length=0;
my $row_count=0;
my $target1="MAS";
my $target2="SAM";

&main;

sub main {
    &read_in($ARGV[0]);
    &check_4_xmas;
}

sub check_4_xmas {
    my $total=0;
    foreach my $row (sort {$a<=>$b} keys %data) {
        foreach my $col (sort {$a<=>$b} keys %{$data{$row}}) {
            if ($data{$row}{$col} eq "A") {
                $total+=&check_for_X($row,$col);
            }
        }
    }
    print "Total is: $total\n";
}

sub check_for_X {
    my $row=shift;
    my $col=shift;
    my $first="";
    my $mid="A";
    my $last="";
    my $count=0;

    if (exists($data{$row-1}{$col-1})) {
        $first=$data{$row-1}{$col-1}; 
    }

    if (exists($data{$row+1}{$col+1})) {
        $last=$data{$row+1}{$col+1}; 
    }

    if ("$first$mid$last" eq $target1 or "$first$mid$last" eq $target2) {
        $count++;
    }

    $first="";
    $last="";

    if (exists($data{$row+1}{$col-1})) {
        $first=$data{$row+1}{$col-1}; 
    }

    if (exists($data{$row-1}{$col+1})) {
        $last=$data{$row-1}{$col+1}; 
    }

    if ("$first$mid$last" eq $target1 or "$first$mid$last" eq $target2) {
        $count++;
    }

    if ($count == 2) {return(1)};

}

sub read_in {
    my $file=shift;
    open(my $fh,$file);
    my $row=0;
    foreach my $line (<$fh>) {
        chomp($line);
        my @tmp=(split("",$line));
        my $count=0;
        foreach my $letter (@tmp) {
            $data{$row}{$count}=$letter;
            $count++;
        }
        $row++;
    }
    close($fh);
}
