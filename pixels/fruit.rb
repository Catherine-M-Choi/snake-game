require_relative "pixel"

class Fruit < Pixel

  FRUITS = %w[🍇 🍈 🍉 🍊 🍋 🍌 🍍 🍎 🍐 🍑 🍒 🍓 🥝]

  def initialize(board, pos)
    super
    @symbol = FRUITS.sample
  end

  def to_s
    # " #{@symbol} " # currently width does not match snake segment length
    "  ".colorize( :background => :red)
  end

  # def spawn_fruit
  #   @pos = @possible_pos.sample
  #   @symbol = FRUITS.sample
  # end

end