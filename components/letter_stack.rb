# frozen_string_literal: true

require_relative 'frequencies'

module Letters
  # Implementation of LetterStack class.
  # This class represents a stack of letter tiles to be used as the "drawing piles" in the Countdown
  # game. The user can choose whether the LetterStack contains consonants or vowels when initializing
  # it. The frequencies for consonants and vowels can be found in {Letters +frequencies.rb+}.
  #
  # @author Zach Baruch
  # @see Letters
  class LetterStack
    include Enumerable

    attr_reader :num_drawn

    # Constructor.
    #
    # @param type [Symbol] the type of LetterStack to be created, +:vowels+ or +:consonants+.
    # @raise [ArgumentError] if +type+ is not a valid type
    def initialize(type = :vowels)
      raise ArgumentError, 'Violation of: type is invalid' unless (type == :vowels) || (type == :consonants)

      create_new_rep type
    end

    # Implementation of {https://ruby-doc.org/core-2.6.6/Enumerable.html#method-i-each_entry +Enumerable#each+}.
    #
    # @see https://ruby-doc.org/core-2.6.6/Enumerable.html#method-i-each_entry Enumerable#each
    def each(&block)
      (@rep.each(&block) if block_given?) or @rep.each
    end

    # Reports the length of +self+.
    #
    # @return [Integer] the number of letters in +self+
    def length
      @rep.length
    end

    # Removes the first letter from +self+ and returns it.
    #
    # @return [String] the first letter from +self+
    def draw
      @num_drawn += 1
      @rep.pop
    end

    # Shuffle elements in +self+ in place.
    def shuffle!
      @rep.shuffle!
    end

    # Returns the array representation of +self+.
    #
    # @return [Array<String>] +self+ represented as an array of strings
    def to_a
      @rep.map { |l| l }
    end

    # Returns the string representation of +self+.
    #
    # @return [String] +self+ represented as a string
    def to_s
      @rep.to_s
    end

    # Equality - Two +LetterStack+s are equal if they contain the same number
    # of letters and if they contain the exact same letters.
    #
    # @return [Boolean] true if +self+ and +other+ are equal, false otherwise
    def ==(other)
      return false if other.nil?
      return false unless other.is_a? LetterStack

      @rep.sort == other.to_a.sort
    end
    alias eql? ==

    # Resets +self+ to an initial state, using the type that it was constructed from.
    # This means that you cannot implicitly convert a LetterStack of consonants to a
    # LetterStack of vowels and vise versa, i.e. it must be done by calling {#initialize}
    def reset
      create_new_rep @type
    end

    # Private methods
    private

    # Creator of initial representation.
    #
    # @param type [Symbol] the type of LetterStack to be created, +:vowels+ or +:consonants+
    def create_new_rep(type)
      @rep = [] # self is represnted as an Array<String>
      @type = type # only used to reset

      # The frequencies for this LetterStack are based on type
      # Doing it this way prevents redundant code
      frequencies = (Letters::VOWEL_FREQUENCIES if type == :vowels) || Letters::CONSONANT_FREQUENCIES

      # For each letter (key), add it to @rep value times (the frequency)
      frequencies.each_key do |x|
        frequencies[x].times { |_i| @rep << x }
      end

      @rep.shuffle! # Mix up the tiles
      @num_drawn = 0 # Set the number of tiles drawn to 0
    end
  end
end
