require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    direction, amount = line.split(' ')
    { direction: direction, amount: amount.to_i }
  end
end

def dive_one(filename)
  inputs = input(filename)

  horizontal = 0
  depth = 0

  inputs.each do |input|
    case input[:direction]
    when 'up'
      depth -= input[:amount]
    when 'down'
      depth += input[:amount]
    when 'forward'
      horizontal += input[:amount]
    end
  end

  horizontal * depth
end

def dive_two(filename)
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
