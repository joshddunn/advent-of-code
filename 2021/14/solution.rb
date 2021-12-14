require_relative "../../helper"

def input(filename)
  input = lines(__FILE__, filename)

  chain = input.shift

  input.shift # empty line

  mappings = input.map { |l| l.split(" -> ") }

  { chain: chain.split(""), mappings: mappings.to_h }
end

def solution(filename, steps = 10)
  inputs = input(filename)

  hash = Hash.new(0)

  inputs[:chain].each_with_index do |c, i|
    next if i.zero?
    hash["#{inputs[:chain][i-1]}#{inputs[:chain][i]}"] += 1
  end

  steps.times do
    new_hash = Hash.new(0)

    hash.keys.each do |key|
      new_hash["#{key[0]}#{inputs[:mappings][key]}"] += hash[key]
      new_hash["#{inputs[:mappings][key]}#{key[1]}"] += hash[key]
    end

    hash = new_hash
  end

  sums = Hash.new(0)
  hash.each { |key, value| sums[key[0]] += value }
  sums[inputs[:chain][-1]] += 1 # add last character in chain

  sums.values.max - sums.values.min
end
