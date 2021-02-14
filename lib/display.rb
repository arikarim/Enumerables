# frozen_string_literal: true

# text nedeed
module Display
  def display_intro
    'lets play a Game!'
  end

  def display_name(number)
    "whats the name of player #{number}"
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
