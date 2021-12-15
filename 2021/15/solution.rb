require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |row|
    row.split("").map(&:to_i)
  end
end

def solution(filename, alternate = false)
  inputs = input(filename)

  if alternate
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

    inputs = new_inputs
  end

  width = inputs[0].length
  height = inputs.length

  graph = Dijkstra.new

  inputs.each_with_index do |row, j|
    row.each_with_index do |_, i|

      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dxdy|
        dx, dy = dxdy

        x = i + dx
        y = j + dy

        next if x < 0 || y < 0 || x >= width || y >= height

        graph.add_edge([i, j], [x, y], inputs[y][x])
      end
    end
  end

  graph.shortest_path([0, 0], [width - 1, height - 1])[1..-1].sum { |coords| inputs.dig(*coords.reverse) }
end
