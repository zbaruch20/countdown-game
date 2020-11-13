# frozen_string_literal: true

require 'ruby2d'
require 'colorize'
require_relative 'components/utilities'
require_relative 'truncator/truncator'

# Main Countdown game.
#
# @author Zach Baruch
module Countdown
  MAX_CONSONANTS = 6
  MAX_VOWELS = 5

  # The "gameplay" part of the game. The Countdown Clock music will be played
  # while the user is guessing words. After the song ends (~30 seconds), the
  # user's latest guess will be submitted.
  def self.countdown_clock
    guess = String.new

    t_input = Thread.new { initialize_input_thread guess }
    t_song = Thread.new { initialize_song_thread t_input }

    t_song.join # Join threads for execution
    t_input.join
    guess # Return the most recent guess
  end

  # Prompts the user to select consonants or vowels nine times, and returns the
  # +TileSet+ containing the nine letters pulled from the respective `LetterStack`s.
  #
  # @return [TileSet] the letters selected by the user, as pulled by the letter stacks
  def self.letters_in_play
    # LetterStacks for consonants and vowels
    consonants = Letters::LetterStack.new :consonants
    vowels = Letters::LetterStack.new :vowels

    # The letters to be selected
    letters = Letters::TileSet.new
    9.times do
      choice = letter_choice(consonants.num_drawn, vowels.num_drawn) # Get choice of consonant or vowel

      # Add selected type of letter to selected_letters
      letters << (choice == 'C' ? consonants.draw : vowels.draw)
      display_tile_set letters
    end
    letters
  end

  # Checks if +guess+ can be formed from +letters+ and is in +valid_words+,
  # and displays the result to the user.
  #
  # @param valid_words [Array<String>] the list of valid words that +guess+ can be
  # @param letters [TileSet] the set of letters that +guess+ must belong to
  # @param guess [String] the user's guess to check
  def self.judge(valid_words, letters, guess)
    if !letters.include? guess
      puts "Sorry, #{guess} uses letters not on the board.".red
    elsif !valid_words.include? guess
      puts "Sorry, #{guess} is not a valid word.".red
    else
      puts "Yes! #{guess} is a valid word!".green
      puts "You earned #{(guess.length if guess.length < 9) || 18} points!".green
    end
    puts
  end

  # Prompts the user if they want to see all possible solutions for +letters+
  # (i.e. each combination of +letters+ that is included in +valid_words+),
  # and if so, displays them to the console.
  #
  # @param valid_words [Array<String>] the list of valid words that +letters+ can be
  # @param letters [TileSet] the set of letters to possibly search for solutions for
  def self.prompt_for_solutions(valid_words, letters)
    # Prompt user for choice, if it is not 'Y' return
    return unless prompt_user('Do you want to see all possible solutions? [Y/N] ', 'Y', 'N').upcase == 'Y'

    # Display all possible solutions
    puts(valid_words.select { |w| letters.include? w }.sort { |a, b| b.length <=> a.length })
  end

  # Plays a round of Countdown.
  #
  # @param valid_words [Array<String>] list of valid words to be used in the game
  def self.play_round(valid_words)
    letters = letters_in_play # Obtain letter set

    display_instructions
    guess = countdown_clock # Run the clock!

    puts "\n\nYour guess is: #{guess}"
    judge valid_words, letters, guess # Check the user's guess
    prompt_for_solutions valid_words, letters # Ask the user if they want to see all solutions
  end

  # Main method.

  display_title # Title screen

  valid_words = word_list

  # Prompt user to play again after each round
  loop do
    play_round valid_words
    break if prompt_user('Do you want to play another round? [Y/N] ', 'Y', 'N').upcase == 'N'
  end
  puts 'Thanks for playing!'
end
