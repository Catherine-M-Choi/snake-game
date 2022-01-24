require_relative "board"
require_relative "cursor"
require "io/console"

class Game

  attr_reader :board, :speed

  def initialize
    @board = Board.new
    @cursor = Cursor.new(board)
    @speed = 1.5/30.0
  end

  def win?
    @board.grid.each do |row|
      row.each do |pix|
        return false unless pix.is_a?(NullPixel)
      end
    end
    true
  end

  def lose?
    !self.board.snake.alive
  end


  def play
    board.render
    @cursor.get_input

    until !self.board.snake.alive
      check_if_input
    end

    if win?
      p "Congrats, you win!"
    else
      p "You lose. Try again."
    end
  end


  def read1maybe
    return $stdin.read_nonblock 3
  rescue Errno::EAGAIN
    return ''
  end
  
  def check_if_input
    system 'stty cbreak'
    while true
      input = read1maybe
      if input.length > 0 
        p input
        key = KEYMAP[input]
        @cursor.handle_key(key)
        break 
      end
      system("clear")
      board.render
      sleep(speed)
      board.snake.move
      break if !self.board.snake.alive
    end
    system 'stty cooked'
  end

end

g = Game.new
g.play
