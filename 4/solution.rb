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
  board.any? { |row| row.sum == -5 } || board.transpose.any? { |col| col.sum == -5 }
end

def board_sum(board)
  board.sum { |row| row.reject(&:negative?).sum }
end

def solution(filename, first_winner = true)
  inputs = input(filename)

  winning_num = nil
  winner = nil

  inputs[:numbers].each do |number|
    inputs[:boards].each_with_index do |board, board_index|
      board.each_with_index do |row, i|
        row.each_with_index do |val, j|
          inputs[:boards][board_index][i][j] = -1 if val == number
        end
      end
    end

    if first_winner || inputs[:boards].count == 1
      winner = inputs[:boards].find { |board| winning_board(board) }
    else
      inputs[:boards] = inputs[:boards].reject { |board| winning_board(board) }
    end

    if winner
      winning_num = number
      break
    end
  end

  board_sum(winner) * winning_num
end
