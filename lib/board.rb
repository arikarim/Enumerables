# frozen_string_literal: true

# Tic-Tac-Toe Board
class Board
  attr_reader :cells

  WINNING_COMBOS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6],
    [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
  ].freeze

  def initialize
    @cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  end

  # rubocop:disable Metrics/AbcSize
  def show
    puts "#{cells[0]} | #{cells[1]} | #{cells[2]}"
    puts '---+---+---'
    puts "#{cells[3]} | #{cells[4]} | #{cells[5]}"
    puts '---+---+---'
    puts "#{cells[6]} | #{cells[7]} | #{cells[8]}"
  end
  # rubocop:enable Metrics/AbcSize

  def update_board(number, symbol)
    @cells[number] = symbol
  end

  def valid_move?(number)
    cells[number - 1] == number
  end

  def full?
    cells.all? { |cell| cell =~ /[^0-9]/ }
  end

  def game_over?
    WINNING_COMBOS.any? do |combo|
      [cells[combo[0]], cells[combo[1]], cells[combo[2]]].uniq.length == 1
    end
  end
end

# nextttttttttt
module Display
  def display_intro
    'welcome, lets start'
  end

  def desplay_name(number)
    "whats the name of player  number #{number}"
  end

  def display_symbol
    'What 1 letter (or special character) would you like to be your game marker?'
  end

  def display_first_symbol(duplicate)
    "it cannot be #{duplicate}"
  end

  def display_warning
    'this is an invalid answer'
  end

  def display_player_turn(name, symbol)
    "#{name}, please enter a number(1-9) to place on the place of #{symbol}"
  end

  def display_winner(player)
    "GAME OVER! #{player} is the WINNER"
  end

  def display_tie
    'its a draw'
  end
end
