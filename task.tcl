
set stringCount 0
set evenCount 0
set oddCount 0
set invalidCount 0

set integersList {}
set stringsList {}

set maxInteger 0
set minStrLen 10000

set infile [open "input.txt" r]
while { [gets $infile line] >= 0 } {
    set printedLine ""

    if {[string is integer -strict $line]} {
        if {$line > $maxInteger} {
            set maxInteger $line
        }
        if {[llength $integersList] < 2} {
            lappend integersList $line
        }

        # check for odds and even numbers
        if {$line % 2 == 0} {
            # multiply the value with 3.25, and print it.
            set even [expr {$line * 3.25}]
            set printedLine $even
            incr evenCount

        } else {
            # divide the value with 2, and print it
            set odd [expr {$line / 2}]
            set printedLine $odd
            incr oddCount
        }
    } elseif {[string match -nocase {[a-z]*} $line] || [string is double $line] } {
        if {[llength $stringsList] < 3} {
            lappend stringsList $line
        }
        set currentLineLen [llength $line]
        if {$currentLineLen < $minStrLen && $currentLineLen > 0} {
            set minStrLen $currentLineLen
        }
        set printedLine $line
        incr stringCount
    } else {
        puts "INVALID LINE"
        incr invalidCount
    }


    set printedLineLen [llength $printedLine]
    puts "Line output: $printedLine, Length of current line: $printedLineLen"
}

close $infile


# print sum of first two integers
if {[llength $integersList] >= 2} {
    lassign $integersList firstInt secondInt
    puts "Sum of first two integers: [expr {$firstInt + $secondInt}]"
}

puts "Concatenation of the first three lines: [join $stringsList " "]"

puts "Maximum Integer: $maxInteger"
puts "Min String: $minStrLen"
puts "Report:\n String count: $stringCount\n Even integers count: $evenCount\n Odd integers count: $oddCount\n Invalid lines count: $invalidCount"
