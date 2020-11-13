# frozen_string_literal: true

require_relative 'tile_set'
require_relative 'letter_stack'
require 'colorize'

# Utility methods for Countdown game.
#
# @author Zach Baruch
module Countdown
  # Initialization function for input thread.
  #
  # @param guess [String] the user's guess to update
  def self.initialize_input_thread(guess)
    loop do
      print 'Enter a guess: '
      guess.replace gets.chomp
    end
  end

  # Initialization function for song thread.
  #
  # @param t_input [Thread] input thread to kill when the song ends
  def self.initialize_song_thread(t_input)
    Music.new('assets/countdown_clock.mp3').play
    sleep 31
    t_input.kill
  end

  # Displays the instructions for each round.
  def self.display_instructions
    puts "\nYou have 30 seconds to find the longest word containing these letters."
    puts "Your most recent guess will be the one accepted.\n"
    puts "Here's the Countdown Clock!\n".blue.bold
    sleep 1
  end

  # Prompts the user for a type of letter to receive (consonant or vowel).
  # If +consonant_count+ exceeds 6, then a vowel will be automatically selected.
  # If +vowel_count+ exceeds 5, then a consonant will be automatically selected.
  #
  # @param consonant_count [Integer] the number of consonants already selected
  # @param vowel_count [Integer] the number of vowels already selected
  # @return [String] the letter choice: +'C'+ for consonant, +'V'+ for vowel
  def self.letter_choice(consonant_count, vowel_count)
    puts
    if consonant_count >= MAX_CONSONANTS # Reached max consonants, must use a vowel
      prompt_user('Maximum consonants reached. You must select a vowel. [V] ', 'V').upcase
    elsif vowel_count >= MAX_VOWELS # Reached max vowels, must use a consonant
      prompt_user('Maximum vowels reached. You must select a consonant. [C] ', 'C').upcase
    else
      prompt_user('Do you want a consonant or a vowel? [C/V] ', 'C', 'V').upcase
    end
  end

  # Displays +ts+ to the console using fancy backgrounds to simulate the tiles
  # on the actual show.
  #
  # @param ts [TileSet] the +TileSet+ to display
  def self.display_tile_set(tile_set)
    letters = tile_set.to_a
    letters[8] ||= nil # "Extend" length to 9
    letters.map! { |x| "[#{x || ' '}]" } # Put the letters in tiles
    puts " #{letters.join} ".on_blue.bold
  end

  # Displays +msg+ to the console, and repeatedly asks for input until it is
  # one of +valid_vals+ (ignoring case). The input value is then returned.
  #
  # @param msg [String] the message to prompt to the user
  # @param *valid_vals [String] one or more valid values that can be returned
  # @return [String] the user's input value
  # @raise [ArgumentError] if +valid_vals+ is empty or contains any nil values
  def self.prompt_user(msg, *valid_vals)
    raise ArgumentError, 'Violation of: valid_vals is not empty' if valid_vals.empty?
    raise ArgumentError, 'Violation of: valid_vals contains no nil values' unless valid_vals.all?

    valid_vals.map!(&:downcase) # Makes each element lowercase, used for ignoring case

    # loop until we get a valid value
    print msg.bold

    until valid_vals.include? (value = gets.chomp).downcase # once we have a valid value, we can return it
      puts "#{value} is not a valid value. Please try again.\n\n" # value must be invalid here
      print msg.bold
    end

    value
  end

  # Prompts the user for a file name containing the list of words they want to use,
  # and returns the words as an +Array+.
  #
  # @return [Array<String>] the list of words in the file specified by the user
  def self.word_list
    print 'Enter the filename containing the list of valid words you want to use: '.bold

    until File.exist?(fname = gets.chomp)
      puts "#{fname} cannot be found. Try again.\n\n"
      print 'Enter the filename containing the list of valid words you want to use: '.bold
    end

    Truncator.tokens(fname).map(&:upcase)
  end

  # Displays the title screen to the console.
  def self.display_title
    # pretty obvious here, just printing some ASCII art line by line
    puts
    puts '   _____    ____    _    _   _   _   _______   _____     ____   __          __  _   _  '.on_blue.bold
    puts '  / ____|  / __ \  | |  | | | \ | | |__   __| |  __ \   / __ \  \ \        / / | \ | | '.on_blue.bold
    puts ' | |      | |  | | | |  | | |  \| |    | |    | |  | | | |  | |  \ \  /\  / /  |  \| | '.on_blue.bold
    puts ' | |      | |  | | | |  | | | . ` |    | |    | |  | | | |  | |   \ \/  \/ /   | . ` | '.on_blue.bold
    puts ' | |____  | |__| | | |__| | | |\  |    | |    | |__| | | |__| |    \  /\  /    | |\  | '.on_blue.bold
    puts '  \_____|  \____/   \____/  |_| \_|    |_|    |_____/   \____/      \/  \/     |_| \_| '.on_blue.bold
    puts '                                                                                       '.on_blue.bold
    puts
  end
end
