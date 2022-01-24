require_relative "board"
require_relative "cursor"

class Game

  attr_reader :board

  def initialize
    @board = Board.new
    # @game_over = false
    @cursor = Cursor.new(board)
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
    until !self.board.snake.alive
      board.render
      @cursor.get_input
      # sleep 2
      board.snake.move
      system("clear")
      # p board.snake.snake_body_pos
      # p board.snake.head.pos
      # p board.snake.alive
    end

    if win?
      p "Congrats, you win!"
    else
      p "You lose. Try again."
    end
  end


  # def direction
    # input = gets.chomp
    # case input
    # when "u"
    #   :up
    # when "d"
    #   :down
    # when "l"
    #   :left
    # when "r"
    #   :right
    # end
  # end

end

g = Game.new
g.play
# p g.board.snake.snake_body_pos

# b = Board.new
# b.render
# s = b.snake
# s.direction = :up
# p b.snake.snake_body_pos
# s.move
# p b.snake.snake_body_pos
# s.move
# p b.snake.snake_body_pos
# b.render

# # b.render

# # # b.update_possible_pos
# # # p b.possible_pos
# # b.render
# # # p b