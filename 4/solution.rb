require 'pry'

def input(filename)
  numbers = nil
  boards = []
  board = []
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    if numbers
      if line.empty?
        boards << board if board.count.positive?
        board = []
      else
        board << line.strip.split(' ').map(&:to_i)
      end
    else
      numbers = line.split(',').map(&:to_i)
    end
  end

  boards << board

  { numbers: numbers, boards: boards }
end

def winning_board(board)
  winner = false
  board.each do |row|
    winner = true if row.sum == -5
  end

  board[0].count.times do |col|
    winner = true if board.map { |b| b[col] }.sum == -5
  end

  winner
end

def board_sum(board)
  board.map do |row|
    row.reject(&:negative?).sum
  end.sum
end

def part_one(filename)
  inputs = input(filename)

  winning_num = 0
  winner = nil

  inputs[:numbers].each do |number|
    inputs[:boards].each_with_index do |board, board_index|
      board.each_with_index do |row, i|
        row.each_with_index do |val, j|
          if val == number
            inputs[:boards][board_index][i][j] = -1
          end
        end
      end
    end

    winner = inputs[:boards].select do |board|
      winning_board(board)
    end

    if winner.count.positive?
      winning_num = number
      break
    end
  end

  board_sum(winner[0]) * winning_num
end

def part_two(filename)
  inputs = input(filename)

  winning_num = 0
  winner = []

  inputs[:numbers].each do |number|
    inputs[:boards].each_with_index do |board, board_index|
      board.each_with_index do |row, i|
        row.each_with_index do |val, j|
          if val == number
            inputs[:boards][board_index][i][j] = -1
          end
        end
      end
    end

    if inputs[:boards].count == 1
      winner = inputs[:boards].select do |board|
        winning_board(board)
      end
    else
      inputs[:boards] = inputs[:boards].reject do |board|
        winning_board(board)
      end
    end

    if winner.count.positive?
      winning_num = number
      break
    end
  end

  board_sum(winner[0]) * winning_num
end
