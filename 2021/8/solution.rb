require_relative "../../helper"

NUMBERS = {
  "abcefg" => 0,
  "cf" => 1,
  "acdeg" => 2,
  "acdfg" => 3,
  "bcdf" => 4,
  "abdfg" => 5,
  "abdefg" => 6,
  "acf" => 7,
  "abcdefg" => 8,
  "abcdfg" => 9
}

PERMUTATIONS = ("a".."g").to_a.permutation(7)

def input(filename)
  lines(__FILE__, filename).map do |line|
    codes, answer = line.split(" | ")
    {
      codes: codes.split(" ").map { |k| k.split("").sort },
      answer: answer.split(" ").map { |k| k.split("").sort }
    }
  end
end

def map_letter(mapper, letter)
  NUMBERS[letter.map { |l| mapper[l] }.sort.join("")]
end

def solve(input)
  letters = ("a".."g").to_a

  PERMUTATIONS.each do |permutation|
    mapper = letters.zip(permutation).to_h
    return input[:answer].map { |answer| map_letter(mapper, answer) } if input[:codes].all? { |code| map_letter(mapper, code) }
  end
end

def solution(filename, alternate = false)
  solutions = input(filename).map { |input| solve(input) }
  alternate ? solutions.sum { |num| num.join("").to_i } : solutions.flatten.filter { |num| [1,4,7,8].include? num }.count
end
