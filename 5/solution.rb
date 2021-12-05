require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    first, second = line.split(' -> ')
    [first.split(',').map(&:to_i), second.split(',').map(&:to_i)]
  end
end

def solution(filename, diagonals = false)
  inputs = input(filename)

  map = {}

  inputs.each do |input|
    first, second = input
    if first[0] == second[0] || first[1] == second[1]
      x_min = [first[0], second[0]].min
      x_max = [first[0], second[0]].max
      if x_min != x_max
        (x_min..x_max).each do |x|
          map["#{x},#{first[1]}"] ||= 0
          map["#{x},#{first[1]}"] += 1
        end
      end

      y_min = [first[1], second[1]].min
      y_max = [first[1], second[1]].max
      if y_min != y_max
        (y_min..y_max).each do |y|
          map["#{first[0]},#{y}"] ||= 0
          map["#{first[0]},#{y}"] += 1
        end
      end
    elsif diagonals
      x_min = [first[0], second[0]].min
      x_max = [first[0], second[0]].max

      m = (second[1] - first[1]) / (second[0] - first[0])
      b = second[1] - m * second[0]

      (x_min..x_max).each do |x|
        map["#{x},#{m * x + b}"] ||= 0
        map["#{x},#{m * x + b}"] += 1
      end
    end
  end

  map.values.sum { |val| val > 1 ? 1 : 0 }
end
