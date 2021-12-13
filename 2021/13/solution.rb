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

def solution(filename, alternate = false)
  inputs = input(filename)

  folds = alternate ? inputs[:folds].count : 1

  folds.times do |fold|
    inputs[:points].each do |point|
      axis, value = inputs[:folds][fold]
      point[axis] = value - (point[axis] - value) if point[axis] > value
    end.uniq!
  end

  array = Array.from_coordinates(inputs[:points])

  array.print if alternate

  { array: array, points: inputs[:points] }
end
