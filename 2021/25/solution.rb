require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split("")
  end
end

class Array
  def height
    length
  end

  def width
    first.length
  end
end

def solution(filename)
  state = input(filename)
  counter = 0
  continue = true

  while continue do
    new_state = Array.new(state.height) { Array.new(state.width, ".") }

    # move east
    state.each_with_index do |row, i|
      row.each_with_index do |val, j|
        next if val == "." || val == "v"
        jj = (j + 1) % state.width
        if state[i][jj] == "."
          new_state[i][jj] = ">"
        else
          new_state[i][j] = ">"
        end
      end
    end

    # move south
    state.each_with_index do |row, i|
      row.each_with_index do |val, j|
        next if val == "." || val == ">"
        ii = (i + 1) % state.height
        if (state[ii][j] == ">" && new_state[ii][j] == ".") || (state[ii][j] == "." && new_state[ii][j] == ".")
          new_state[ii][j] = "v"
        else
          new_state[i][j] = "v"
        end
      end
    end

    continue = false if state.inspect == new_state.inspect

    counter += 1
    state = new_state
  end

  counter
end
