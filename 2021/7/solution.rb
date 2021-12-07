require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).first.split(",").map(&:to_i)
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
