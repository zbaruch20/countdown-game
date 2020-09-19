# Provides methods related to tokenizing an input file, and writing to
# a new file all words in the input less than a specified length.
#
# @author Zach Baruch
module Truncator

    # Tokenizes the file whose name is [input_name], and returns an array
    # containing all the words in the file (not including empty strings),
    # separated by [separators], in the order the words appeared in the file.
    #
    # @param input_name [String] the name of the file to tokenize
    # @param separators [Regexp] regular expression of separators, /\W/ by default
    # @return [Array] the words in [input_name] of non-zero length
    # @requires input_name exists
    # @ensures stuff
    def self.tokens(input_name, separators = /\W/)
        raise "Violation of: input_name is a String" unless input_name.is_a? String
        raise "Violation of: separators is a Regexp" unless separators.is_a? Regexp
        raise "Violation of: input_name exists" unless File.exist? input_name

        File.read(input_name).split(separators).select {|s| s.length > 0}
    end

end