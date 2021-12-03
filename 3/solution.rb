require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    line
  end
end

def part_one(filename, length)
  inputs = input(filename)

  bits = Array.new(length, 0)

  inputs.each do |input|
    length.times do |time|
      bits[time] = input[time] == '1' ? bits[time] + 1 : bits[time] - 1
    end
  end

  gamma_bits = bits.map { |bit| bit >= 0 ? '1' : '0' }
  epsilon_bits = bits.map { |bit| bit >= 0 ? '0' : '1' }

  gamma_rate = gamma_bits.join('').to_i(2)
  epsilon_rate = epsilon_bits.join('').to_i(2)

  gamma_rate * epsilon_rate
end

def most_common_value(inputs, index = 0)
  return inputs[0] if inputs.count == 1

  grouped = inputs.group_by { |input| input[index] }

  grouped['0'] ||= []
  grouped['1'] ||= []

  most_common_value(grouped['1'].count >= grouped['0'].count ? grouped['1'] : grouped['0'], index + 1)
end

def least_common_value(inputs, index = 0)
  return inputs[0] if inputs.count == 1

  grouped = inputs.group_by { |input| input[index] }

  grouped['0'] ||= []
  grouped['1'] ||= []

  least_common_value(grouped['0'].count <= grouped['1'].count ? grouped['0'] : grouped['1'], index + 1)
end

def part_two(filename)
  inputs = input(filename)

  oxygen_generator_rating = most_common_value(inputs).to_i(2)
  co2_scrubber_rating = least_common_value(inputs).to_i(2)

  oxygen_generator_rating * co2_scrubber_rating
end

puts "Part 1 Example: #{part_one('example.txt', 5)}"
puts "Part 1: #{part_one('input.txt', 12)}"
puts ''
puts "Part 2 Example: #{part_two('example.txt')}"
puts "Part 2: #{part_two('input.txt')}"
