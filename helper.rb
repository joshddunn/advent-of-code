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
