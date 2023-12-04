my $filename = 'day2/day2input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my $sum = 0;
my $powerSum = 0;

while (my $line = <$fh>) {
    chomp $line;

    $line =~ /Game (\d+)/;
    my $game = $1;

    my @bags = split /[:;]/ , $line;
    my $valid = 1;
    my $gameRed = 0;
    my $gameBlue = 0;
    my $gameGreen = 0;
    foreach $bag ( @bags ) {
        chomp $bag;
        #print $bag . "\n";
        my $red = 0;
        my $green = 0;
        my $blue = 0;
        if ( $bag =~ /(\d+) red/ ) {
            $red = $1;
            if ( $red > $gameRed) { $gameRed = $red; }
        }
        if ( $bag =~ /(\d+) blue/ ) {
            $blue = $1;
            if ( $blue > $gameBlue) { $gameBlue = $blue; }
        }
        if ( $bag =~ /(\d+) green/ ) {
            $green = $1;
            if ( $green > $gameGreen) { $gameGreen = $green; }
        }

        my $bagValid = 1;
        if ( $red > 12) {
            $bagValid = 0;
        }
        if ( $blue > 14) {
            $bagValid = 0;
        }
        if ( $green > 13) {
            $bagValid = 0;
        }

        #print "Red: " . $red . ", Blue: " . $blue . ", Green: " . $green . ", Valid: " . $bagValid . "\n";

        if ( not $bagValid ) {
            $valid = $bagValid;
        }
    }

    if ( $valid ) {
        $sum = $sum + $game;
    }

    $gamePower = $gameRed * $gameGreen * $gameBlue;
    #print $gamePower . "\n";
    $powerSum = $powerSum + $gamePower;
}

close($fh);

print "Valid sums: " . $sum . "\n";
print "Power sums: " . $powerSum;
