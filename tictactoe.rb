# Helper class to store board information and organize some methods
class GridOfCells
  attr_reader :n
  attr_reader :cells_rows
  attr_reader :cells_columns
  attr_reader :cells_diagonals

  attr_reader :filled_cells

  # Initialize a 2D n x n array of 0s
  def initialize(n)
    @n = n
    @cells_rows = Array.new(n) { Array.new(n) { 0 } }
    @cells_columns = Array.new(n) { Array.new(n) { 0 } }
    @cells_diagonals = Array.new(2) { Array.new(n) { 0 } }

    @filled_cells = 0
  end

  public

  def [](x)
    @cells_rows[x]
  end

  def update_cell(row, col, val)
    @cells_rows[row][col] = val
    @cells_columns[col][row] = val
    
    if row == col then @cells_diagonals[0][row] = val
    elsif n - 1 - col == row then @cells_diagonals[1][row] = val
    end

    @filled_cells += 1
  end

  def is_full?
    @filled_cells == @n * @n
  end

  private

  def debug
    puts "Rows : #{@cells_rows}"
    puts "Cols : #{@cells_columns}"
    puts "Diags : #{@cells_diagonals}"
  end
end

class TicTacToe
  attr_reader :n
  attr_reader :finished
  attr_reader :player_1s_turn

  # 1 if player 1 wins, 2 if player 2 wins, 0 if draw
  attr_reader :result

  # Initialize a Tic Tac Toe board of grid_size * grid_size (aka n * n)
  def initialize(grid_size)
    @finished = false
    @player_1s_turn = [true, false].sample

    @n = grid_size
    @cells_grid = GridOfCells.new(@n)
  end

  def start
    puts  "  ------  Tic Tac Toe (#{@n} x #{@n})  ------  \n"\
          "-- How to Play :\n'"\
          "> The game will prompt you where to place your O/X on the board.\n"\
          "> When prompted, enter the desired position in the following format :\n"\
          "  - [row letter] [column number]\n"\
          "  - e.g : a3, B1, C 3, a 4\n"\
          "  - invalid entries : 3A, 13, here\n"\
          "> The first one to get #{@n} Os/Xs in a line wins\n"\
          "> Type 'exit' or 'quit' (case-insensitive) to quit mid-game.\n"\
          "---------------------------------------"
    puts "Player 1 - X, Player 2 - O"
    puts "Player #{@player_1s_turn ? 1 : 2} start!"
    
    print_board
    game_loop
  end

  private

  # Main game loop
  def game_loop
    until @finished
      i_tuple = prompt_player
      @cells_grid.update_cell(i_tuple[0], i_tuple[1], @player_1s_turn ? 1 : 2)

      print_board
      check_board
      @player_1s_turn = !@player_1s_turn
    end

    puts @result
  end

  def check_board
    @cells_grid.cells_rows.each do |row|
      found = has_same_values?(row)

      if found
        @result = row[0]
        @finished = true
        return
      end
    end

    @cells_grid.cells_columns.each do |col|
      found = has_same_values?(col)

      if found
        @result = col[0]
        @finished = true
        return
      end
    end

    @cells_grid.cells_diagonals.each do |diag|
      found = has_same_values?(diag)

      if found
        @result = diag[0]
        @finished = true
        return
      end
    end

    if @cells_grid.is_full?
      @result = 0
      @finished = true
    end
  end

  # Checks the whole array if it is non-empty and has the same values
  def has_same_values? (array)
    same = true

    array.each do |element|
      if element != array[0] || element == 0
        same = false
        break
      end
    end

    same
  end

  # Prompts the current player where to put his/her/its O/X
  # Returns the intended cell indices
  def prompt_player
    valid = false     # Flag to stop reprompting when input is valid
    x, y = -1

    print "Player #{@player_1s_turn ? 1 : 2}'s turn (#{@player_1s_turn ? 'X' : 'O'}) : "

    # Repeat input prompt until input is valid
    until valid
      player_input = gets.chomp
      player_input = player_input.tr(' ', '').upcase

      exit(true) if player_input == 'EXIT' || player_input == 'QUIT'

      x = player_input[0].ord - 65
      y = (player_input[1] =~ /[[:digit:]]/) == 0 ? player_input[1].to_i - 1 : nil;

      if player_input.length != 2 || x < 0 || x > n - 1 || y < 0 || y > n - 1 || y.nil?
        print "Invalid input, TRY ANOTHER! : "
        next
      elsif @cells_grid[x][y] != 0
        print "Cell occupied, TRY ANOTHER! : "
        next
      end

      valid = true
    end
    
    [x, y]
  end

  # Prints the current state of the board
  def print_board
    # Print top number row
    print "\n       "
    (1..@n).each { |x| print "#{x} "}
    print "\n\n"

    # Print letter column and board
    (0..@n - 1).each do |y|
      letter = (97 + y).chr
      print "    #{letter}  "

      (0..@n - 1).each do |x|
        if @cells_grid[y][x] == 0
          print "  "
        else
          print "#{@cells_grid[y][x] == 1 ? 'X' : 'O'} "
        end
      end

      print "\n"
    end

    print "\n"
  end

  def debug
    @cells_grid.each do |row|
      row.each do |element|
        print "#{element} "
      end
      print "\n"
    end
  end
end

tic_tac_toe = TicTacToe.new(4)
tic_tac_toe.start