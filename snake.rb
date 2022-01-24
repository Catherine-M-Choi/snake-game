Dir['./pixels/*.rb'].each{ |f| require f }

class Snake

  attr_reader :body
  attr_accessor :direction, :head, :points, :board, :alive

  DIRECTIONS = {
    :up =>[-1, 0],  
    :down => [1, 0],
    :left =>[0, -1],
    :right =>[0, 1]
  }.freeze

  def initialize(board)
    @body = [SnakeSegment.new(board, [20,30])]
    @head = SnakeSegment.new(board, [20,30])
    @board = board
    @direction = nil
    @points = 0
    @alive = true
  end

  def enqueue(segment)
    body.unshift(segment)
  end

  def dequeue
    tail_pos = body[-1].pos
    body.pop
    board[tail_pos] = NullPixel.instance
  end

  def possible_dirs
    case direction
    when nil
      [:up, :down, :left, :right]
    when :up, :down
      [:left, :right]
    when :left, :right
      [:up, :down]
    end
  end

  def move  
    dir = DIRECTIONS[direction]
    cur_x, cur_y = head.pos
    diff_x, diff_y = dir
    next_pos = [cur_x + diff_x, cur_y + diff_y]
    new_head = SnakeSegment.new(board, next_pos)

    if snake_body_pos.include?(next_pos) || out_of_bounds?(next_pos)
      self.alive = false 
    else
    
      enqueue(new_head)
      if board[next_pos].is_a?(Fruit)
        @points += 10
        board.fruit_exists = false
      else
        dequeue 
      end
      self.head = new_head
    end
  end

  def snake_body_pos
    body.map { |segment| segment.pos }
  end

  def out_of_bounds?(next_pos)
    x, y = next_pos
    !x.between?(0, 39) || !y.between?(0, 59)
  end

end