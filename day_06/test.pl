#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my %data=();
my %cur=(
    'row'=>0,
    'col'=>0,
);
my @direction=(
    [-1,0], #up
    [0,1],  #right
    [1,0],  #down
    [0,-1], #left
);

&main;

sub main {
    my $file=$ARGV[0];
    &read_in($file);
    &start_moving;
    my $count=&count_it;
    print "Count:$count\n";

}

sub start_moving {
    my $movement=0;
    while (1==1) {
        print "CurrentRow:$cur{'row'} CurrentCol:$cur{'col'}\n";
        #&print_it;
        my $desire_row=$cur{'row'}+$direction[$movement][0];
        my $desire_col=$cur{'col'}+$direction[$movement][1];
        if (exists($data{$desire_row}{$desire_col})) {
            if ($data{$desire_row}{$desire_col} eq ".") {
                $data{$desire_row}{$desire_col}="X";
                $cur{'row'}=$desire_row;
                $cur{'col'}=$desire_col;
            } 
            elsif ($data{$desire_row}{$desire_col} eq "#") {
                if ($movement <= 2) {
                    $movement++;
                }
                else {
                    $movement=0;
                }
            }
            elsif ($data{$desire_row}{$desire_col} eq "X" or $data{$desire_row}{$desire_col} eq "^") {
                $data{$desire_row}{$desire_col}="X";
                $cur{'row'}=$desire_row;
                $cur{'col'}=$desire_col;
            }
        }
        else {
            last;
        }
    }
}

sub count_it {
    my $count=0;
    foreach my $row (sort{$a<=>$b} keys %data) {
        foreach my $col (sort{$a<=>$b} keys %{$data{$row}}) {
            if ($data{$row}{$col} eq "X") {
                $count++;
            }
        }
    }
    &print_it;
    return($count);
}

sub print_it {
    foreach my $row (sort{$a<=>$b} keys %data) {
        foreach my $col (sort{$a<=>$b} keys %{$data{$row}}) {
            print "$data{$row}{$col}";
        }
        print "\n";
    }
    print "-------------------\n";
}

sub read_in {
    my $file=shift;
    my $row=0;
    open(my $fh,$file);
    foreach my $line (<$fh>) {
        chomp($line);
        my $col=0;
        foreach my $item (split//,$line) {
            $data{$row}{$col}=$item;
            if ($item eq "^") {
                $cur{'row'}=$row;            
                $cur{'col'}=$col;
                $data{$row}{$col}="X";
            }
            $col++;
        }
        $row++;
    }
    close($fh);
}
