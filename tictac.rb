class Game
  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ].freeze

  def play(board)
    turn(board) until over?(board)
    if won?(board)
      puts "Congratulations #{winner(board)} you won!"
    elsif draw?(board)
      puts "Cat's Game!"
    end
  end

  def display_board(board)
    puts " #{board[0]} | #{board[1]} | #{board[2]} "
    puts '-----------'
    puts " #{board[3]} | #{board[4]} | #{board[5]} "
    puts '-----------'
    puts " #{board[6]} | #{board[7]} | #{board[8]} "
  end

  def valid_move?(board, index)
    index.between?(0, 8) && !position_taken?(board, index)
  end

  def won?(board)
    WIN_COMBINATIONS.detect do |combo|
      board[combo[0]] == board[combo[1]] &&
        board[combo[1]] == board[combo[2]] &&
        position_taken?(board, combo[0])
    end
  end

  def full?(board)
    board.all? { |token| %w[X O].include?(token) }
  end

  def draw?(board)
    !won?(board) && full?(board)
  end

  def over?(board)
    won?(board) || draw?(board)
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def turn(board)
    puts 'Please enter 1-9:'
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(board, index)
      move(board, index, current_player(board))
      display_board(board)
    else
      puts "#{user_input} is used Please enter another number"
      turn(board)
    end
  end

  def position_taken?(board, index)
    board[index] == 'X' || board[index] == 'O'
  end

  def current_player(board)
    turn_count(board).even? ? 'X' : 'O'
  end

  def turn_count(board)
    board.count { |token| %w[X O X O X O].include?(token) }
  end

  def move(board, index, player)
    board[index] = player
  end

  def winner(board)
    winning_combo = won?(board)
    board[winning_combo.first]
  end
end

board = [' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ']

lets_play = Game.new

lets_play.display_board(board)

lets_play.play(board)
