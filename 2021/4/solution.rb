require_relative "../../helper"

def input(filename)
  boards = []
  board = []

  lines = lines(__FILE__, filename)

  numbers = lines.shift.split(',').map(&:to_i)

  lines.shift # empty line

  lines.each do |line|
    if line.empty?
      boards << board
      board = []
    else
      board << line.strip.split(' ').map(&:to_i)
    end
  end

  boards << board

  { numbers: numbers, boards: boards }
end

def winning_board(board)
  board.any?(&:none?) || board.transpose.any?(&:none?)
end

def solution(filename, first_winner = true)
  inputs = input(filename)

  inputs[:numbers].each do |number|
    inputs[:boards].map! do |board|
      board.map { |row| row.map { |val| val == number ? nil : val } }
    end

    if first_winner || inputs[:boards].count == 1
      if (winner = inputs[:boards].find { |board| winning_board(board) })
        return winner.flatten.compact.sum * number
      end
    else
      inputs[:boards].reject! { |board| winning_board(board) }
    end
  end
end
