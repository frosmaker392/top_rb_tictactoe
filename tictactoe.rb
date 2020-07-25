class TicTacToe
  attr_reader :n
  attr_reader :finished
  attr_reader :player_1s_turn

  # Initialize a Tic Tac Toe board of grid_size * grid_size (aka n * n)
  def initialize(grid_size)
    @finished = false
    @player_1s_turn = [true, false].sample

    @n = grid_size
    @cells_grid = Array.new(@n) do |y|
      Array.new(@n) { |x| 0}
    end

    puts "Player 1 - X, Player 2 - O"
    
    print_board
    game_loop
  end

  private

  # Main game loop
  def game_loop
    until finished
      i_tuple = prompt_player
      @cells_grid[i_tuple[0]][i_tuple[1]] = @player_1s_turn ? 1 : 2
      print_board

      @player_1s_turn = !@player_1s_turn
    end
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
      player_input = player_input.tr(' ', '').capitalize

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
    print '    '
    (1..@n).each { |x| print "#{x} "}
    print "\n\n"

    # Print letter column and board
    (0..@n - 1).each do |y|
      letter = (97 + y).chr
      print " #{letter}  "

      (0..@n - 1).each do |x|
        if @cells_grid[y][x] == 0
          print "  "
        else
          print "#{@cells_grid[y][x] == 1 ? 'X' : 'O'} "
        end
      end

      print "\n"
    end
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