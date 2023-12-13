my $filename = 'day5/day5input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my %seeds;
my %map;

#Part 2
my %seedsB;
my %mapB;

while (my $line = <$fh>) {
    chomp $line;

    if (index($line, "seeds:") != -1) {
        while ($line =~ m/(\d+)/g)
        {
            $seeds{$1} = $1;
        }

        #Part 2
        while ($line =~ m/(\d+)\s(\d+)/g)
        {
            $seedsB{$1} = $2;
        }
    }
    elsif (index($line, "map:") != -1 ) {
        undef %map;
        undef %mapB;
    }
    elsif ($line =~ m/(\d+)\s(\d+)\s(\d+)/) {
        my $destStart = $1;
        my $sourceStart = $2;
        my $range = $3;
        #print "Dest: " . $destStart . ", Source: " . $sourceStart . ", Range: " . $range . "\n";

        foreach my $a (keys %seeds) {
            my $b = $seeds{$a};
            if ($b >= $sourceStart && $b <= $sourceStart + $range - 1) {
                my $offset = $b - $sourceStart;
                #print "Seed: " . $a . ", B: " . $b . ", Start: " . $sourceStart . ", Offset: " . $offset . ", Next: " . ($destStart + $offset) . "\n";
                $map{$a} = $destStart + $offset;
                
            }
        }

        #Part 2
        foreach my $seed (keys %seedsB) {
            my $length = $seedsB{$a};
            my $seedEnd = $seed + $length - 1;
            my $seedsStartWithinRange = $seed >= $sourceStart && $seed <= $sourceStart + $range - 1;
            my $seedsEndWithinRange = $seedEnd >= $sourceStart && $seedEnd <= $sourceStart + $range - 1;
            my $fullyWithinRange = $seedsStartWithinRange && $seedsEndWithinRange;
            my $partiallyWithinRange = not $fullyWithinRange && ($seedsStartWithinRange || $seedsEndWithinRange);
            if ( $partiallyWithinRange ){
                # Will need to split the ranges
                my $newRangeA = $sourceStart - $seed;
                my $newRangeB = $length - $newRangeA;
                $seedsB{$seed} = $newRangeA;
                $seedsB{$sourceStart} = $newRangeB;
            }
        }
        # Loop again after splitting to actually process into map
        foreach my $seed (keys %seedsB) {
            if ($seed >= $sourceStart && $seed <= $sourceStart + $range - 1) {
                my $offset = $seed - $sourceStart;
                $mapB{$seed} = ($destStart + $offset);
            }
        }
    }
    elsif ($line =~ m/^$/) {
        #Move the map values to the main hash
        foreach my $mapA (keys %map) {
            $seeds{$mapA} = $map{$mapA};
        }

        #Part 2
        foreach my $mapBA (keys %mapB) {
            if ($mapBA == 82) {
                #print "Seed: " . $mapBA . ", B: " . $mapB{$mapBA} . "\n";
            }
            $seedsB{$mapBA} = $mapB{$mapBA};
        }
    }
}
close($fh);

#Need to move the map one last time at end of file
#Move the map values to the main hash
foreach my $mapA (keys %map) {
    $seeds{$mapA} = $map{$mapA};
}
foreach my $mapBA (keys %mapB) {
    $seedsB{$mapBA} = $mapB{$mapBA};
}

#Part 1
my $min = (values %seeds)[0];
foreach my $seed (keys %seeds) {
    my $location = $seeds{$seed};
    #print "Seed: " . $seed . ", Location: " . $location . "\n";
    if ($location < $min){
        $min = $location;
    }
}
print "Min: " . $min . "\n";

#Part 2
my $minB = (values %seedsB)[0];
foreach my $seed (keys %seedsB) {
    my $location = $seedsB{$seed};
    #print "Seed: " . $seed . ", Location: " . $location . "\n";
    if ($location < $minB){
        $minB = $location;
    }
}
print "Min B: " . $minB . "\n";