require 'pry'
require 'set'
require 'colorize'

def spec(actual, expected)
  if actual == expected
    puts "success"
  else
    puts "failed: got #{actual} expected #{expected}"
  end
end

def lines(source, filename)
  File.read("#{File.dirname(source)}/#{filename}").split("\n")
end

class Counter
  attr_reader :items

  def initialize
    @items = Hash.new(0)
  end

  def add(key)
    @items[key] += 1
  end
end

class Array
  def self.from_coordinates(coordinates)
    max_x = coordinates.map(&:first).max
    max_y = coordinates.map(&:last).max

    Array.new(max_y + 1) { Array.new(max_x + 1, 0) }.tap do |array|
      coordinates.each do |point|
        array[point[1]][point[0]] += 1
      end
    end
  end

  def print
    puts ""
    self.each do |row|
      puts row.map { |p| p.positive? ? " ".on_white : " " }.join
    end
  end
end
