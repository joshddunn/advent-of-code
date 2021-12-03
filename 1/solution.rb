require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map(&:to_i)
end

def increments(filename)
  values = input(filename)

  count = 0

  values.length.times do |index|
    next if index.zero?
    count += 1 if values[index] > values[index - 1]
  end

  count
end

def sliding_increments(filename)
  values = input(filename)

  count = 0

  values.length.times do |index|
    next if index < 3
    window_one = values[index - 1] + values[index - 2] + values[index - 3]
    window_two = values[index] + values[index - 1] + values[index - 2]
    count += 1 if window_two > window_one
  end

  count
end

puts "Example: #{increments('example.txt')}"
puts "Part 1: #{increments('input.txt')}"
puts "Part 2: #{sliding_increments('input.txt')}"
