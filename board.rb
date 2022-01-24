Dir['./pixels/*.rb'].each{ |f| require f }
require_relative "snake"

class Board

  attr_reader :grid
  attr_accessor :possible_pos, :grid, :fruit_exists, :snake

  def initialize
    @grid = Array.new(40) {Array.new(60) {NullPixel.instance} }
    @speed = 0.5
    @snake = Snake.new(self)

    @possible_pos = []
    grid.each_with_index do |row, i|
      row.each_with_index { |pix, j| possible_pos << [i, j] if pix.is_a?(NullPixel) }
    end
    @fruit_exists = false

    # @grid[0][0] = SnakeSegment.new(self)
    # @grid[1][1] = Fruit.new(self)
  end
  
  def render
    update_grid_snake
    if !@fruit_exists
      spawn_fruit
      @fruit_exists = true
    end

    puts "-"*120
    grid.each do |row|
      puts "|" + row.map{ |pix| pix.to_s }.join("") + "|"
    end
    puts "-"*120
    puts "Score: #{snake.points}"
  end

  def [](pos)
    row, col = pos
    grid[row][col]
  end

  def []=(pos,val)
    row, col = pos
    grid[row][col] = val
  end

  def update_possible_pos
    possible_pos = []
    grid.each_with_index do |row, i|
      row.each_with_index { |pix, j| possible_pos << [i, j] if pix.is_a?(NullPixel) }
    end
  end

  def update_grid_snake
    snake.body.each do |segment|
      self[segment.pos] = segment
      # p segment
    end
  end

  def spawn_fruit
    update_possible_pos
    fruit_pos = possible_pos.sample
    self[fruit_pos] = Fruit.new(self, fruit_pos)
  end

  # Moved this to snake class
  # def out_of_bounds?(pos)
  #   x, y = pos
  #   x.between?(0, 39) && x.between?(0, 59)
  # end
end

