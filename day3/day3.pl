use List::MoreUtils qw(uniq);
my $filename = 'day3/day3input.txt';

open(my $fh, '<', $filename) or die "Could not open file '$filename' $!";

my $sum = 0;
my %ratioList;

my @lines = ('', '' ,'');

sub getSymbolsForLine {
    my $line = $_[0];
    my @symbolList;
    while ($line =~ m/[^\d\.]/g)
    {
        push(@symbolList, pos($line) - 1);
    }
    return @symbolList;
}

sub processRatioSymbolsForLine {
    my $index = $_[0] + 1;
    my $line = $_[1];
    while ($line =~ m/\*/g)
    {
        my $position = pos($line) - 1;

        #print "Index: " . $index . ", Line: " . $line . ", Position: " . $position . "\n";
        $ratioList{$index}{$position} = ();
    }
}

sub checkRatioForNumber {
    my $index = $_[0];
    my $testRow = $_[1];
    my $number = $_[2];
    my $numStart = $_[3];
    my $numEnd = $_[4];

    my @ratioPositions = keys @ratios;
    foreach my $ratioPos ( keys %{$ratioList{$testRow}} ) {
        #print "Test row: " . $testRow . ", Start: " . $numStart . ", End: " . $numEnd . "Ratio Pos: " . $ratioPos . ", Number: " . $number . "\n";
        if ( $ratioPos >= $numStart && $ratioPos <= $numEnd ) {
            push(@{$ratioList{$testRow}{$ratioPos}}, $number);
        }
        #print join(",", @{$ratioList{$testRow}{$ratioPos}});
    }
}

sub processLine {
    my $index = $_[0];
    my $nextLine = $_[1];
    shift(@lines);
    push (@lines, $nextLine);

    processRatioSymbolsForLine($index, $nextLine);

    #Get symbols in previous line
    my $prevLine = @lines[0];
    my @prevLineSymbols = getSymbolsForLine($prevLine);

    #Get symbols in next line
    my $nextLine = @lines[2];
    my @nextLineSymbols = getSymbolsForLine($nextLine);

    #Get numbers in current line
    my $currLine = @lines[1];
    my @currLineSymbols = getSymbolsForLine($currLine);

    my @allSymbols;
    push (@allSymbols, @prevLineSymbols, @currLineSymbols, @nextLineSymbols);
    @allSymbols = uniq(@allSymbols);
    sort (@allSymbols);
    #print join (", ", @allSymbols) . "\n";

    while ($currLine =~ m/(\d+)/g)
    {
        my $numStart = $-[1] - 1;
        my $numEnd = $+[1];
        my $num = $1;
        #print $num . "|" . $numStart . "|" . $numEnd . "\n";
        my $found = 0;
        foreach ( @allSymbols) {
            if ( not($found) && $_ >= $numStart && $_ <= $numEnd ) {
                $found = 1;
                #print $num . "|" . $numStart . "|" . $_ . "|" . $numEnd . "\n";
                $sum = $sum + $num
            }
        }

        my $ratioFound = 0;
        #Add to ratio list as well
        checkRatioForNumber($index, $index - 1, $num, $numStart, $numEnd);
        checkRatioForNumber($index, $index, $num, $numStart, $numEnd);
        checkRatioForNumber($index, $index + 1, $num, $numStart, $numEnd);
    }
}

my $index = -1;
while (my $line = <$fh>) {
    chomp $line;

    processLine($index, $line);
    $index++;
}
close($fh);

processLine($index, '');

print "Sum: " . $sum . "\n";

my $ratioSum = 0;
#Find ratios with only two values
foreach my $ratioLine ( keys %ratioList ) {
    foreach my $ratioPos ( keys %{$ratioList{$ratioLine}} ) {
        my @gears = @{$ratioList{$ratioLine}{$ratioPos}};
        if ( scalar @gears == 2) {
            #print "Gear 1: " . @gears[0] . ", Gear 2: " . @gears[1] . "\n";
            $ratioSum = $ratioSum + (@gears[0] * @gears[1]);
        }
    }
}

print "Ratio: " . $ratioSum;