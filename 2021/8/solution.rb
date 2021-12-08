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
    OpenStruct.new(
      codes: codes.split(" "),
      answer: answer.split(" ")
    )
  end
end

def mutate(letters, to)
  NUMBERS[letters.tr("abcdefg", to.join).split("").sort.join]
end

def solve(input)
  PERMUTATIONS.each do |permutation|
    if input.codes.all? { |code| mutate(code, permutation) }
      return input.answer.map { |answer| mutate(answer, permutation) }
    end
  end
end

def solution(filename, alternate = false)
  solutions = input(filename).map { |input| solve(input) }
  alternate ? solutions.sum { |num| num.join("").to_i } : solutions.flatten.filter { |num| [1,4,7,8].include? num }.count
end
