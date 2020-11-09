require_relative 'frequencies'

# Implementation of LetterStack class.
# This class represents a stack of letter tiles to be used in the Countdown game. The user
# can choose whether the LetterStack contains consonants or vowels when initializing it. The
# frequencies for consonants and vowels can be found in `frequencies.rb`.
#
# @author Zach Baruch
module Letters
    class LetterStack
        include Enumerable

        # Constructor.
        #
        # @param type [Symbol] the type of LetterStack to be created, `:vowels` or `:consonants`.
        #   By default, this will be `:vowels`. If this is not one of the valid values, an
        #   `ArgumentError` will be raised.
        def initialize(type = :vowels)
            raise ArgumentError.new('Violation of: type is invalid') unless (type == :vowels or type == :consonants)

            @rep = [] # self is represnted as an Array<String>

            # The frequencies for this LetterStack are based on type
            # Doing it this way prevents redundant code
            frequencies = (Letters::Vowel_frequencies if type == :vowels) || Letters::Consonant_frequencies

            # For each letter (key), add it to @rep value times (the frequency)
            frequencies.each_key do |x|
                frequencies[x].times {|i| @rep << x}
            end

            @rep.shuffle! # Mix up the tiles
        end

        # Implementation of `Enumerable#each`
        def each(&block)
            (@rep.each &block if block_given?) or @rep.each
        end

        # Reports the length of `self`.
        #
        # @return [Integer] the number of letters in `self`
        def length()
            @rep.length
        end

        # Removes the first letter from `self` and returns it.
        #
        # @return [String] the first letter from `self`
        def draw()
            @rep.pop
        end

        # Shuffle elements in `self` in place.
        def shuffle!()
            @rep.shuffle!
        end

        # Returns the array representation of `self`.
        #
        # @return [Array<String>] `self` represented as an array
        def to_a()
            @rep
        end

    end
end