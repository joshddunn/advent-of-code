require 'pry'
require 'set'

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
