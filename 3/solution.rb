require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    # put stuff here
  end
end

def part_one(filename)
  inputs = input(filename)
end

def part_two(filename)
  inputs = input(filename)
end

puts "Part 1 Example: #{part_one('example.txt')}"
puts "Part 1: #{part_one('input.txt')}"

puts "Part 2 Example: #{part_two('example.txt')}"
puts "Part 2: #{part_two('input.txt')}"
