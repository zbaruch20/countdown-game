# Provides methods related to tokenizing an input file, and writing to
# a new file all words in the input less than a specified length.
#
# @author Zach Baruch
module Truncator

    # Reads from [input_file], and writes to [output_file] all of the words
    # in [input_file] containing only letters and whose length is less than
    # [max_len]. If [output_file] does not exist, it will be created. Otherwise,
    # it will be overwritten.
    #
    # @param input_file [String] the name of the file to read words from
    # @param output_file [String] the name of the file to write the truncated words to
    # @param max_len [Integer] the maximum length of the words to be written to [output_file]
    # @requires <pre>
    #  input_file exists  and
    #  max_len > 0
    #  </pre>
    # @ensures <pre>
    #  tokens(output_file) is subset of tokens(input_file)  and
    #  for all w: string of character
    #    where (w is in entries(tokens(output_file)))
    #   (|x| <= max_len  and  [w contains only letters])
    #  </pre>
    def self.truncate(input_file, output_file, max_len)
        raise "Violation of: input_file is a String" unless input_file.is_a? String
        raise "Violation of: output_file is a String" unless output_file.is_a? String
        raise "Violation of: max_len is an Integer" unless max_len.is_a? Integer
        raise "Violation of: #{input_file} exists" unless File.exist? input_file
        raise "Violation of: max_len > 0" unless max_len > 0

        out = File.new output_file, 'w+'
        tokens = tokens(input_file, /[^\w\-.']/).map {|w| w.downcase}
        tokens.each { |w| out.puts w if w.length <= max_len and w.match? /^[a-z]$/ }
        out.close
    end

    # Tokenizes the file whose name is [input_file], and returns an array
    # containing all the words in the file (not including empty strings),
    # separated by [separators], in the order the words appeared in the file.
    #
    # @param input_file [String] the name of the file to tokenize
    # @param separators [Regexp] regular expression of separators, /\W/ by default
    # @return [Array] the words in [input_file] of non-zero length
    # @requires input_file exists
    # @ensures stuff
    def self.tokens(input_file, separators = /\W/)
        raise "Violation of: input_file is a String" unless input_file.is_a? String
        raise "Violation of: separators is a Regexp" unless separators.is_a? Regexp
        raise "Violation of: #{input_file} exists" unless File.exist? input_file

        File.read(input_file).split(separators).select {|s| s.length > 0}
    end

end