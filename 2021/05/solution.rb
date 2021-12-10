require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    first, second = line.split(' -> ')
    x1, y1 = first.split(',').map(&:to_i)
    x2, y2 = second.split(',').map(&:to_i)
    [OpenStruct.new(x: x1, y: y1), OpenStruct.new(x: x2, y: y2)]
  end
end

def solution(filename, diagonals = false)
  inputs = input(filename)

  map = Hash.new(0)

  inputs.each do |input|
    first, second = input

    if first.x == second.x
      Range.new(*[first.y, second.y].sort).each { |y| map["#{first.x},#{y}"] += 1 }
    else
      m = (second.y - first.y) / (second.x - first.x)
      b = second.y - m * second.x

      next unless m.zero? || diagonals

      Range.new(*[first.x, second.x].sort).each { |x| map["#{x},#{m * x + b}"] += 1 }
    end
  end

  map.values.sum { |val| val > 1 ? 1 : 0 }
end
