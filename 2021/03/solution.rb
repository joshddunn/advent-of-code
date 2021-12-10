require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename)
end

def diagnostic_one(filename)
  inputs = input(filename)
  length = inputs[0].length

  bits = Array.new(length, 0)

  inputs.each do |input|
    length.times do |index|
      bits[index] = input[index] == '1' ? bits[index] + 1 : bits[index] - 1
    end
  end

  gamma_rate = bits.map { |bit| bit >= 0 ? '1' : '0' }.join('').to_i(2)
  epsilon_rate = bits.map { |bit| bit >= 0 ? '0' : '1' }.join('').to_i(2)

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

def diagnostic_two(filename)
  inputs = input(filename)

  oxygen_generator_rating = most_common_value(inputs).to_i(2)
  co2_scrubber_rating = least_common_value(inputs).to_i(2)

  oxygen_generator_rating * co2_scrubber_rating
end
