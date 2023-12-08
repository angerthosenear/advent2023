my $filename = 'day4/day4input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

#Part 1
my $sum = 0;

#Part 2
my $cardNum = 1;
my $cardCounts = 0;
my @cardCopies = (0);

while (my $line = <$fh>) {
    chomp $line;
    #Part 1
    my $cardVal = 0;

    #Part 2
    my $cardWins = 0;
    my $currCardCopies = shift @cardCopies;
    #print "Card num: " . $cardNum . ", Copies: " . $currCardCopies . "\n";

    my @card = split(/[\:\|]/, $line);
    my @winning;
    push (@winning,$&) while($card[1] =~ /(\d+)/g );
    my %winHash = map { $_ => 1 } @winning;
    my @sample;
    push (@sample,$&) while($card[2] =~ /(\d+)/g );

    foreach my $num ( @sample ) {
        if (exists($winHash{$num})) {
            #Part 1
            if ($cardVal == 0) {
                $cardVal = 1;
            }
            else {
                $cardVal = $cardVal * 2;
            }

            #Part 2
            $cardWins++;
        }
    }
    #print $cardVal . "\n";
    $sum = $sum + $cardVal;

    #Part 2
    $cardCounts += $currCardCopies + 1;
    #print "Card num: " . $cardNum . ", Total: " . $cardCounts . "\n";
    if ($cardWins > 0) {
        for my $i (0 .. $cardWins - 1) {
            #if(exists($cardCopies[$i])) 
            #{
            #    $cardCopies[$i]++;
            #}
            #else
            #{
            #    $cardCopies[$i] = 1
            #}
            $cardCopies[$i] += $currCardCopies + 1;
        }
    }
    else {
        $cardCopies[0] += 0;
    }
    $cardNum++;

    #print "Card wins: " . $cardWins . ", Card Count: " . ($currCardCopies + 1) . "\n";
    #print join(",", @cardCopies) . "\n";
}

close($fh);

print "Sum: " .$sum . "\n";
print "Card counts: " . $cardCounts;