my $filename = 'day6/day6input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my $dof = 1;

my %raceTimes;
my %raceRecords;
my %raceDof;

while (my $line = <$fh>) {
    chomp $line;

    my $isTimes = index($line, "Time:") != -1;

    my $raceIndex = 1;
    while ($line =~ m/(\d+)/g)
    {
        if ($isTimes) {
            $raceTimes{$raceIndex} = $1;
        }
        else {
            $raceRecords{$raceIndex} = $1;
        }
        $raceIndex++;
    }
}
close($fh);


# Part 1
foreach my $index ( keys %raceTimes ){
    # Calculate DOFs
    my $raceTime = $raceTimes{$index};
    my $raceRecord = $raceRecords{$index};

    for (my $holdTime = 0; $holdTime < $raceTime; $holdTime++) {
        my $testDistance = $holdTime * ($raceTime - $holdTime);
        if ( $testDistance > $raceRecord ){
            $raceDof{$index}++;
        }
    }
    #print "Race: " . $index . ": " . $raceDof{$index} . "\n";
    $dof = $dof * $raceDof{$index};
}

print "Part 1: " . $dof . "\n";

# Part 2
my $concatTime = "";
my $concatRecord = "";
my $dof2 = 0;
my $raceCount = keys %raceTimes;

# Doing this instead of keys to guarantee order
for (my $index = 1; $index <= $raceCount; $index++ ){
    # Calculate DOFs
    my $raceTime = $raceTimes{$index};
    my $raceRecord = $raceRecords{$index};

    $concatTime = $concatTime . $raceTime;
    $concatRecord = $concatRecord . $raceRecord;
}

#print "Concat Race:: Time: " . $concatTime . ", Record: " . $concatRecord . "\n";

# Slow brute force approach
for (my $holdTime = 0; $holdTime < $concatTime; $holdTime++) {
    my $testDistance = $holdTime * ($concatTime - $holdTime);
    if ( $testDistance > $concatRecord ){
        $dof2++;
    }
}

print "Part 2: " . $dof2 . "\n";
