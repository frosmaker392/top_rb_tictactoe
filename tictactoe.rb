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
  attr_reader :finished
  attr_reader :player_1s_turn

  # Initialize a Tic Tac Toe board of grid_size * grid_size (aka n * n)
  def initialize(grid_size)
    @finished = false
    @player_1s_turn = true

    @n = grid_size
    @cells_grid = Array.new(@n) do |x|
      Array.new(@n) do |y|
        Cell.new
      end
    end
    
    debug
    game_loop
  end

  private

  def game_loop
    until finished
      i_tuple = prompt_player
      @cells_grid[i_tuple[0]][i_tuple[1]].content = @player_1s_turn ? 1 : 2
      debug

      @player_1s_turn = !@player_1s_turn
    end
  end

  # Prompts the current player where to put his/her/its O/X
  # Returns the intended cell indices
  def prompt_player
    valid = false     # Flag to stop reprompting when input is valid
    x = -1
    y = -1

    print "Player #{@player_1s_turn ? 1 : 2}'s turn (#{@player_1s_turn ? 'O' : 'X'}) : "

    # Repeat input prompt until input is valid
    until valid
      player_input = gets.chomp
      player_input = player_input.gsub(' ', '').capitalize

      x = player_input[0].ord - 65
      y = (player_input[1] =~ /[[:digit:]]/) == 0 ? player_input[1].to_i - 1 : nil;

      if player_input.length != 2 || x < 0 || x > n - 1 || y < 0 || y > n - 1 || y.nil?
        print "Invalid input, TRY ANOTHER! : "
        next
      elsif @cells_grid[x][y].content != 0
        print "Cell occupied, TRY ANOTHER! : "
        next
      end

      valid = true
    end

    return [x, y]
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