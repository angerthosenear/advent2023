my $filename = 'day1input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my $sum = 0;

while (my $line = <$fh>) {
    chomp $line;

    $line =~ s/one/o1e/g;
    $line =~ s/two/t2o/g;
    $line =~ s/three/t3e/g;
    $line =~ s/four/f4r/g;
    $line =~ s/five/f5e/g;
    $line =~ s/six/s6x/g;
    $line =~ s/seven/s7n/g;
    $line =~ s/eight/e8t/g;
    $line =~ s/nine/n9e/g;

    $line =~ /^.*?(\d)/;
    my $first = $1;
    $line =~ /.*(\d).*?$/;
    my $last = $1;
    my $both = $first . $last;
    #print $both . "\n";
    $sum = $sum + $both;
}

close($fh);

print $sum;
