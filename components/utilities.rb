require_relative 'tile_set'
require_relative 'letter_stack'
require 'colorize'

# Utility methods for Countdown game.
#
# @author Zach Baruch
module Countdown

  # Displays the title screen to the console.
  def self.display_title
    puts '   _____    ____    _    _   _   _   _______   _____     ____   __          __  _   _  '.on_blue
    puts '  / ____|  / __ \  | |  | | | \ | | |__   __| |  __ \   / __ \  \ \        / / | \ | | '.on_blue
    puts ' | |      | |  | | | |  | | |  \| |    | |    | |  | | | |  | |  \ \  /\  / /  |  \| | '.on_blue
    puts ' | |      | |  | | | |  | | | . ` |    | |    | |  | | | |  | |   \ \/  \/ /   | . ` | '.on_blue
    puts ' | |____  | |__| | | |__| | | |\  |    | |    | |__| | | |__| |    \  /\  /    | |\  | '.on_blue
    puts '  \_____|  \____/   \____/  |_| \_|    |_|    |_____/   \____/      \/  \/     |_| \_| '.on_blue
    puts '                                                                                       '.on_blue
  end

end