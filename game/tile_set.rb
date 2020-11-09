# frozen_string_literal: true

# Implementation of TileSet class.
# This class represents a set of letter tiles to be used as the "letters in play" in the Countdown
# game. All of the drawn letters should be added to a TileSet, and it can be used to check if
# the player's guess contains only the letters in play.
module Letters
  class TileSet
    include Enumerable
  end
end
