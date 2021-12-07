require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").first.split(",").map(&:to_i)
end

def solution(filename, alternate = false)
  inputs = input(filename)

  (inputs.min..inputs.max).map do |val|
    inputs.sum do |input|
      amount = (input - val).abs
      alternate ? amount * (amount + 1) / 2 : amount
    end
  end.min
end
