# Countdown Letters Game

This game, implemented in Ruby, is an adaptation of the letters game from the British game show "Countdown". In this game, the player selects nine consonants and vowels at random from corresponding stacks of letters (one for consonants, one for vowels). The player then has 30 seconds to come up with the longest word they can using the letters they selected. If their chosen word is correct, i.e. is a subset of the multiset of the available letters and is an element of a list of valid words, provided by the user. This list of valid words to be used is loaded from a separate file when the game begins execution.

You can see an example of the game in action [here](https://youtu.be/JPNJHoOtBrg?t=191). First, you want to make sure you have Ruby and some necessary sdl2 packages installed. On Ubuntu or Debian, you can do this by executing the following command:

```
$ sudo apt-get install ruby-full libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev
```

To run the game, first simply download all the files into a directory, and enter the following command in a console window inside the game's main directory:

```
$ bundle exec ruby countdown.rb
```
-------------------

For convenience, the file ```words.txt```, containing all words in the English language containing only letters with a length of nine or less (i.e. ```/^[a-z]{1,9}$/```), is provided. This file is adapted from [this GitHub repository](https://github.com/dwyl/english-words). While I wrote a script to restrict the original file (`raw-words.txt`) to words of nine or less characters (```truncator.rb```), all credit for the original file belongs to dwyl and all contributors to the aforementioned repository.

The main game is implemented in the module ```Countdown```, and the word list tokenizer components are implemented in the module ```Truncator```. The module  ```Letters``` provides an implementation of the ```LetterStack``` and `TileSet` classes used for the consonant and vowel stacks and the letters in play, respectively.
