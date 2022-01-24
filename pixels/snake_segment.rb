require_relative "pixel"
require "colorize"

class SnakeSegment < Pixel

  attr_reader :pos
  
  def initialize(board, pos)
    super
    @symbol = :green
  end

  def color=(new_color)
    @symbol = new_color
  end

  def to_s
    "  ".colorize( :background => @symbol)
  end
  
end