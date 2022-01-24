require "io/console"
require_relative 'board'

KEYMAP = {
"q" => :quit,
"\e" => :escape,
"\e[A" => :up,
"\e[B" => :down,
"\e[C" => :right,
"\e[D" => :left,
}.freeze

class Cursor

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def get_input
    key = KEYMAP[read_char]
    handle_key(key)
  end

  def read_char
    STDIN.echo = false # stops the console from printing return values

    STDIN.raw! # in raw mode data is given as is to the program--the system
                # doesn't preprocess special characters such as control-c

    input = STDIN.getc.chr # STDIN.getc reads a one-character string as a
                            # numeric keycode. chr returns a string of the
                            # character represented by the keycode.
                            # (e.g. 65.chr => "A")

    if input == "\e" then
      input << STDIN.read_nonblock(3) rescue nil # read_nonblock(maxlen) reads
                                                  # at most maxlen bytes from a
                                                  # data stream; it's nonblocking,
                                                  # meaning the method executes
                                                  # asynchronously; it raises an
                                                  # error if no data is available,
                                                  # hence the need for rescue

      input << STDIN.read_nonblock(2) rescue nil
    end

    STDIN.echo = true # the console prints return values again
    STDIN.cooked! # the opposite of raw mode :)

    return input
  end

  def handle_key(key)
    if [:up, :down, :left, :right].include?(key)
      board.snake.direction = key
    elsif key == :quit || key == :escape
      Process.exit(0)
    end
  end

end