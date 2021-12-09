require_relative "../../helper"

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

def search(root, inputs, queue = [])
  queue = queue.push root

  inputs[root[:x]][root[:y]] = nil

  queue.concat search({ x: root[:x] + 1, y: root[:y] }, inputs, queue) if root[:x] + 1 < inputs.length && inputs[root[:x] + 1][root[:y]] == 0
  queue.concat search({ x: root[:x] - 1, y: root[:y] }, inputs, queue) if root[:x] - 1 >= 0 && inputs[root[:x] - 1][root[:y]] == 0
  queue.concat search({ x: root[:x], y: root[:y] + 1 }, inputs, queue) if root[:y] + 1 < inputs[0].length && inputs[root[:x]][root[:y] + 1] == 0
  queue.concat search({ x: root[:x], y: root[:y] - 1 }, inputs, queue) if root[:y] - 1 >= 0 && inputs[root[:x]][root[:y] - 1] == 0

  queue.uniq
end

def solution_two(filename)
  inputs = input(filename).map do |row|
    row.map do |col|
      col == 9 ? 1 : 0
    end
  end

  clusters = []

  inputs.each_with_index do |row, i|
    row.each_with_index do |val, j|
      clusters.push(search({ x: i, y: j }, inputs)) if inputs[i][j] == 0
    end
  end

  clusters.map { |c| c.count }.sort.last(3).inject(&:*)
end
