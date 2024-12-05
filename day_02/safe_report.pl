#!/usr/bin/perl

use strict;
use warnings;

&main;

sub main {
    &read_input($ARGV[0]);
}

sub read_input {
    my $file=shift;
    my $val=0;
    open(my $fh,$file);
    foreach my $line (<$fh>) {
        chomp($line);
        my @l=split/\s+/,$line;
        #$val+=&check_safe(\@l);
        $val+=&dampener(\@l);
    }
    close($fh);
    print "Valid: $val\n";
}

sub dampener {
    my $the_data=shift;
    my @data=map {int($_)} @$the_data;
    my $count=scalar(@data)-1;

    if ($data[0] > $data[$count]) {
        @data=reverse(@data);
    }
     
    my($val,$bad)=&check_valid(\@data);

    if ($val==1) {
        return(1);
    }
    else {
        if ($bad==1) {
            my @yo=@data;
            splice(@yo,0,1);
            my ($val,$bad)=&check_valid(\@yo);
            if ($val==1) {
                return(1);
            }
        }
        splice(@data,$bad,1);
        my ($val,$bad)=&check_valid(\@data);
        if ($val==1) {
            return(1);
        }
        return(0);
    }
}

sub check_valid {
    my $data=shift;
    my $count=scalar(@$data)-1;
    for(my $i=0;$i<$count;$i++) {
        my $delta=$$data[$i+1]-$$data[$i];
        if ($delta < 0) {
            return(0,$i);
        }
        if ($delta > 3 or $delta < 1) {
            return(0,$i);
        }
    }
    return(1,0);
}

sub check_safe {
    my $the_data=shift;
    my @data=map {int($_)} @$the_data;
    my $count=scalar(@data)-1;

    if ($data[0] > $data[$count]) {
        @data=reverse(@data);
    }

    for(my $i=0;$i<$count;$i++) {
        my $delta=$data[$i+1]-$data[$i];
        if ($delta < 0) {
            return(0);
        }
        if ($delta > 3 or $delta < 1) {
            return(0);
        }
    }
    return(1);
}
