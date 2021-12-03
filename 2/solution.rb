require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    direction, amount = line.split(' ')
    { direction: direction, amount: amount.to_i }
  end
end

def multiplication(filename)
  inputs = input(filename)

  x = 0
  y = 0

  inputs.each do |input|
    case input[:direction]
    when 'up'
      y -= input[:amount]
    when 'down'
      y += input[:amount]
    when 'forward'
      x += input[:amount]
    end
  end

  x * y
end

def depth_multiplication(filename)
  inputs = input(filename)

  horizontal = 0
  aim = 0
  depth = 0

  inputs.each do |input|
    case input[:direction]
    when 'up'
      aim -= input[:amount]
    when 'down'
      aim += input[:amount]
    when 'forward'
      horizontal += input[:amount]
      depth += aim * input[:amount]
    end
  end

  horizontal * depth
end

puts "Part 1 Example: #{multiplication('example.txt')}"
puts "Part 1: #{multiplication('input.txt')}"

puts "Part 2 Example: #{depth_multiplication('example.txt')}"
puts "Part 2: #{depth_multiplication('input.txt')}"
