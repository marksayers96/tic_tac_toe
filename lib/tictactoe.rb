# def display_board (board)
#   cell = "   "
#   row = cell + "|" + cell + "|" + cell
#   rowDiv = "-----------"
#   puts " " + board[0] + " | " + board[1] + " | " + board[2] + " "
#   puts rowDiv
#   puts " " + board[3] + " | " + board[4] + " | " + board[5] + " "
#   puts rowDiv
#   puts " " + board[6] + " | " + board[7] + " | " + board[8] + " "
# end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# code your input_to_index and move method here!
def input_to_index(nextmove)
  nextmovei = nextmove.to_i - 1
end

def move(board,index,player)
  board[index] = player;
end

def position_taken?(board,index_number)
  # do some error checking
  #if index_number>9 || index_number<0
  #  return true
  #else
  if board[index_number] == nil
    return false
  elsif board[index_number]=="" || board[index_number]==" "
      return false
  else
    return true
  end
end

def valid_move?(board,index_number)
  if !index_number.between?(0,8)
    return false
  elsif position_taken?(board,index_number)
    return false
  else
    return true
  end
end

def turn(board)
  # Invite move
  puts "Please enter 1-9:"
  nmove = gets.strip
  # Convert user input to index
  nmovei = input_to_index(nmove)
  while !valid_move?(board,nmovei)
    puts "Oops. Try again."
    puts "Please enter 1-9:"
    nmove = gets.strip
    # Convert user input to index
    nmovei = input_to_index(nmove)
  end
  move(board,nmovei,current_player(board))
  display_board(board)
end

def move(board,index,player)
  board[index] = player;
end

def play(board)
  # turn_count = 1
  # while turn_count <= 9
  #   turn(board)
  #   turn_count += 1
  # end
  while !over?(board)
    turn(board)
  end
  if won?(board)
    puts ("Congratulations #{winner(board)}!")
  elsif draw?(board)
    puts ("Cats Game!")
  end
end

def current_player(board)
  # player X starts

  turn_count(board) % 2 == 0 ? "X" : "O"
  #if turn_count(board) % 2 == 0
    # since X starts, an event turn count means X is up next
  #  return "X"
  #else
  #  return "O"
  #end
end

def turn_count(board)
  count = 0
  board.each do |space|
    if space!=" "
      count += 1
    end
  end
  return count
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

# Won - return the board positions if someone has won
def won?(board)
  # cycle through WIN_COMBINATIONS
  WIN_COMBINATIONS.detect { |winning_combo|
    # print win_index
    # print '\n'
    position_taken?(board,winning_combo[0]) &&
      position_taken?(board,winning_combo[1]) &&
      position_taken?(board,winning_combo[2]) &&
      board[winning_combo[0]] == board[winning_combo[1]] &&
      board[winning_combo[1]] == board[winning_combo[2]]
  }
end

# Full? Return true if board is full
def full?(board)
  board.find { |square| square.nil? || square == " " } ? false : true
end

# Draw? Return true if board is full and is a draw
#       Return false is board not full or there is a winner
def draw?(board)
  board_complete = full?(board)
  board_won = won?(board)
  board_complete && !board_won ? true : false
end

# Over? Return if the board has been won, is a draw, or is full.
def over?(board)
  full?(board) || won?(board) || draw?(board)
end

# Winner accept a board and return the token, "X" or "O" that has won the game given a winning board.
def winner(board)
  # Return the square entry from the winning configuration
  won?(board) ? board[won?(board)[0]] : nil
end

# Define your WIN_COMBINATIONS constant
WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # First column
  [1,4,7], # Second column
  [2,5,8], # Third column
  [0,4,8], # Diagonal 1
  [2,4,6]  # Diagonal 2
  # ETC, an array for each win combination
]
