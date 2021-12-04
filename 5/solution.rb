require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    # put stuff here
    line
  end
end

def part_one(filename)
  inputs = input(filename)
end

def part_two(filename)
  inputs = input(filename)
end
