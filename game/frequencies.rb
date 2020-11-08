# Contains the frequencies for consonants and vowels used for the LetterStack implementation.
# These may be updated if one desires to change letter frequencies. The frequencies of the
# consonants and vowels are based off the letter frequencies from the English edition of Scrabble,
# obtained from https://scrabble.hasbro.com/en-us/faq.
#
# @author Zach Baruch
module Letters

    # Hash<String, Integer> of consonant frequencies in the LetterStack
    @@Consonant_frequencies = {
        'B' => 2,
        'C' => 2,
        'D' => 4,
        'F' => 2,
        'G' => 3,
        'H' => 2,
        'J' => 1,
        'K' => 1,
        'L' => 4,
        'M' => 2,
        'N' => 6,
        'P' => 2,
        'Q' => 1,
        'R' => 6,
        'S' => 4,
        'T' => 6,
        'V' => 2,
        'W' => 2,
        'X' => 1,
        'Y' => 2,
        'Z' => 1
    }

    # Hash<String, Integer> of vowel frequencies in the LetterStack
    @@Vowel_frequencies = {
        'A' => 9,
        'E' => 12,
        'I' => 9,
        'O' => 8,
        'U' = > 4
    }

end