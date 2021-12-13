require_relative "../../helper"

def input(filename)
  blank = false
  points = []
  folds = []

  lines(__FILE__, filename).each do |line|
    if line.empty?
      blank = true
      next
    end

    if blank
      folds << line
    else
      points << line
    end
  end

  points = points.map { |p| p.split(",").map(&:to_i) }

  folds = folds.map do |fold|
    match = fold.match(/fold along ([xy])=(.+)/)
    [match[1] == "x" ? 0 : 1, match[2].to_i]
  end

  { points: points, folds: folds }
end

def solution(filename, folds = Float::INFINITY)
  inputs = input(filename)

  [inputs[:folds].count, folds].min.times do |fold|
    inputs[:points].map! do |point|
      axis, value = inputs[:folds][fold]
      point[axis] = value - (point[axis] - value) if point[axis] > value
      point
    end.uniq!
  end

  max_x = inputs[:points].map(&:first).max
  max_y = inputs[:points].map(&:last).max

  array = Array.new(max_y + 1) { Array.new(max_x + 1) }

  inputs[:points].each do |point|
    array[point[1]][point[0]] = 1
  end

  array.each do |row|
    puts row.map { |p| p ? "#" : " " }.join
  end

  { array: array, points: inputs[:points] }
end
