require_relative "../../helper"
require "set"

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split("").map(&:to_i)
  end
end

def solution(filename)
  inputs = input(filename)

  width = inputs[0].length
  height = inputs.length

  low_points = {}

  inputs.each_with_index do |row, i|
    row.each_with_index do |val, j|
      if (i + 1 >= height || inputs[i + 1][j] > val) &&
         (i - 1 < 0 || inputs[i - 1][j] > val) &&
         (j + 1 >= width || inputs[i][j + 1] > val) &&
         (j - 1 < 0 || inputs[i][j - 1] > val)
        low_points["#{i} #{j}"] = val
      end
    end
  end

  low_points.values.sum { |val| val + 1 }
end

def search(root, inputs, queue = Set.new)
  queue = queue.add root

  inputs[root[:x]][root[:y]] = nil

  x = root[:x] + 1
  y = root[:y]
  queue.merge search({ x: x, y: y }, inputs, queue) if x < inputs.length && inputs[x][y] == 0

  x = root[:x] - 1
  y = root[:y]
  queue.merge search({ x: x, y: y }, inputs, queue) if x >= 0 && inputs[x][y] == 0

  x = root[:x]
  y = root[:y] + 1
  queue.merge search({ x: x, y: y }, inputs, queue) if x < inputs[0].length && inputs[x][y] == 0

  x = root[:x]
  y = root[:y] - 1
  queue.merge search({ x: x, y: y }, inputs, queue) if y >= 0 && inputs[x][y] == 0

  queue
end

def solution_two(filename)
  inputs = input(filename).map do |row|
    row.map do |col|
      col == 9 ? 1 : 0
    end
  end

  clusters = []

  inputs.each_with_index do |row, x|
    row.each_with_index do |val, y|
      clusters.push(search({ x: x, y: y }, inputs)) if inputs[x][y] == 0
    end
  end

  clusters.map { |c| c.count }.sort.last(3).inject(&:*)
end
