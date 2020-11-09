# frozen_string_literal: true

# Main application for Truncator module
# @author Zach Baruch

require_relative 'truncator'
require 'colorize'

puts "Word Truncator\n".light_cyan.bold

# Prompt for parameters
print 'Enter input file name: '
input_file = gets.chomp
print 'Enter output file name: '
output_file = gets.chomp
print 'Enter maximum word length: '
max_len = gets.chomp.to_i

# Perform the truncation
Truncator.truncate input_file, output_file, max_len

puts "\nFinished file output!".light_cyan.bold
