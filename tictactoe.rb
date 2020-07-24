class Cell
  # content - represents which player has filled in the cell
  # 1 - Player 1, 2 - Player 2
  attr_accessor :content

  def initialize
    @content = 0
  end
end

class TicTacToe
  attr_reader :n

  # Initialize a Tic Tac Toe board of grid_size * grid_size (aka n * n)
  def initialize(grid_size)
    @n = grid_size
    @cells_grid = Array.new(@n) do |x|
      Array.new(@n) do |y|
        Cell.new
      end
    end

    debug
  end

  def debug
    @cells_grid.each do |row|
      row.each do |element|
        print "#{element.content} "
      end
      print "\n"
    end
  end
end

tic_tac_toe = TicTacToe.new(4)