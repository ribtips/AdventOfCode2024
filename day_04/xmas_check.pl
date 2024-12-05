#!/usr/bin/perl

use strict;
use warnings;
use Data::Dumper;

my %data=();
my $length=0;
my $row_count=0;
my $target="XMAS";
my %coords=(
    'forward'=>{
        'row'=>[0,0,0],
        'col'=>[1,2,3],
        'tmp'=>[],
    },

    'backward'=>{
        'row'=>[0,0,0],
        'col'=>[-1,-2,-3],
        'tmp'=>[],
    },

    'up'=>{
        'row'=>[-1,-2,-3],
        'col'=>[0,0,0],
        'tmp'=>[],
    },

    'down'=>{
        'row'=>[1,2,3],
        'col'=>[0,0,0],
        'tmp'=>[],
    },

    'diag_up_right'=>{
        'row'=>[-1,-2,-3],
        'col'=>[1,2,3],
        'tmp'=>[],
    },

    'diag_down_right'=>{
        'row'=>[1,2,3],
        'col'=>[1,2,3],
        'tmp'=>[],
    },

    'diag_up_left'=>{
        'row'=>[-1,-2,-3],
        'col'=>[-1,-2,-3],
        'tmp'=>[],
    },

    'diag_down_left'=>{
        'row'=>[1,2,3],
        'col'=>[-1,-2,-3],
        'tmp'=>[],
    },

);

&main;

sub main {
    &read_in($ARGV[0]);
    print Dumper %data;
    &check_4_xmas;
}

sub check_4_xmas {
    my $total=0;
    foreach my $row (sort {$a<=>$b} keys %data) {
        foreach my $col (sort {$a<=>$b} keys %{$data{$row}}) {
            $total+=&check_it_hash($row,$col);
        }
    }
    print "Total is: $total\n";
}

sub check_it_hash {
    my $row=shift;
    my $col=shift;
    my $vals=0;
    foreach my $test (keys %coords) {
        $coords{$test}{'tmp'}[0]=$data{$row}{$col};
        for (my $i=0;$i<3;$i++) {
            my $row_diff=$coords{$test}{'row'}[$i];
            my $col_diff=$coords{$test}{'col'}[$i];
            if (exists($data{$row+$row_diff}{$col+$col_diff})) {
                push @{$coords{$test}{'tmp'}},$data{$row+$row_diff}{$col+$col_diff};
            }
        }
        my $str=join("",@{$coords{$test}{'tmp'}});
        if (join("",@{$coords{$test}{'tmp'}}) eq $target) {
            #print "Valid $test!: Row:$row Col:$col Val:$data{$row}{$col}\n";
            $vals++;
        }
        @{$coords{$test}{'tmp'}}=();
    }
    return($vals);
}

sub read_in {
    my $file=shift;
    open(my $fh,$file);
    my $row=0;
    foreach my $line (<$fh>) {
        chomp($line);
        #push @{$data{$row_count}},(split("",$line));
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
