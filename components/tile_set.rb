# frozen_string_literal: true

module Letters
  # Implementation of TileSet class.
  # This class represents a set of letter tiles to be used as the "letters in play" in the Countdown
  # game. All of the drawn letters should be added to a TileSet, and it can be used to check if
  # the player's guess contains only the letters in play.
  #
  # @author Zach Baruch
  class TileSet
    include Enumerable

    # Constructor. +self+ will be empty.
    def initialize
      create_new_rep
    end

    # Implementation of {https://ruby-doc.org/core-2.6.6/Enumerable.html#method-i-each_entry +Enumerable#each+}.
    # @see https://ruby-doc.org/core-2.6.6/Enumerable.html#method-i-each_entry Enumerable#each
    def each(&block)
      (@rep.each(&block) if block_given?) or @rep.each
    end

    # Adds +letter+ to +self+. +letter+ must be a string containing a single letter
    # character, i.e. +letter =~ /^[A-Za-z]{1}$/+ must be true.
    #
    # @param letter [String] the letter to add to this.
    # @raise [ArgumentError] if +letter+ is not a single letter character
    def add(letter)
      unless letter.is_a?(String) && letter =~ (/^[A-Za-z]{1}$/)
        raise ArgumentError, 'Violation of: letter is a single letter character'
      end

      @rep << letter.upcase
    end
    alias << add

    # Checks if +word+ only contains the letters in +self+. Note that +word+ must
    # be non-empty and contain only letters, i.e. +word =~ /^[A-Za-z]\+$/+ must be true.
    #
    # @param word [String] the word to check for inclusion in +self+
    # @return [Boolean] true if +word+ only contains the letters in +self+, false otherwise
    # @raise [ArgumentError] if +word+ is empty or contains non-letters
    def include?(word)
      unless word.is_a?(String) && word =~ (/^[A-Za-z]+$/)
        raise ArgumentError, 'Violation of: word is non-empty and contains only letters'
      end

      # Simple case here, if the word's length is longer than the length of self, then
      # self does not contain word
      return false if (word.upcase! || word).length > @rep.length

      available_letters = @rep.map { |c| c } # Array copy

      word.each_char do |c|
        # If c is not one of the available letters, then self does not contain word
        return false unless available_letters.include? c

        # Remove c from available_letters, this avoids duplicates in available_letters
        available_letters.delete_at(available_letters.index(c))
      end

      true # If we made it here then self contains word
    end

    # Reports the length of +self+.
    #
    # @return [Integer] the number of elements in +self+
    def length
      @rep.length
    end

    # Returns the array representation of +self+.
    #
    # @return [Array<String>] +self+ represented as an array of strings
    def to_a
      @rep.map { |l| l }
    end

    # Returns the string representation of +self+
    #
    # @return [String] +self+ represented as a string
    def to_s
      "{#{@rep.map { |c| "\"#{c}\"" }.join ', '}}"
    end

    # Resets +self+ to an initial state.
    def clear
      create_new_rep
    end

    # Equality - Two +TileSet+s are equal if they contain the same number
    # of letters and if they contain the exact same letters.
    #
    # @return [Boolean] true if +self+ and +other+ are equal, false otherwise
    def ==(other)
      return false if other.nil? || !other.is_a?(TileSet)

      @rep.sort == other.to_a.sort
    end
    alias eql? ==

    # Private methods
    private

    # Creator of initial representation.
    def create_new_rep
      @rep = []
    end
  end
end
