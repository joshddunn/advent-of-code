require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |row|
    row.split("").map(&:to_i)
  end
end

def expanded_input(filename)
  inputs = input(filename)

  inputs.map! do |row|
    new_row = []
    5.times do |iter|
      row.each do |val|
        new_row << (val + iter - 1) % 9 + 1
      end
    end
    new_row
  end

  new_inputs = []
  5.times do |iter|
    inputs.each do |row|
      new_inputs << row.map do |val|
        (val + iter - 1) % 9 + 1
      end
    end
  end

  new_inputs
end


def solution(filename, alternate = false)
  inputs = alternate ? expanded_input(filename) : input(filename)

  graph = Dijkstra.new

  max_index = inputs.length - 1

  inputs.each_with_index do |row, j|
    row.each_with_index do |_, i|

      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dxdy|
        dx, dy = dxdy

        x = i + dx
        y = j + dy

        next if x < 0 || y < 0 || x > max_index || y > max_index

        graph.add_edge([i, j], [x, y], inputs[y][x])
      end
    end
  end

  graph.shortest_path([0, 0], [max_index, max_index])[1..-1].sum { |coords| inputs.dig(*coords.reverse) }
end
