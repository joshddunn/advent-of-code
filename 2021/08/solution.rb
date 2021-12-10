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
      codes: codes.split(" ").sort { |a, b| a.length <=> b.length },
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
  solutions = input(filename).map { |input| solve_fast(input) }
  alternate ? solutions.sum { |num| num.join("").to_i } : solutions.flatten.filter { |num| [1,4,7,8].include? num }.count
end

#####################
# fast alt solution #
#####################

def solve_fast(input)
  # first and second mapping
  permutations = input.codes[0].split("").permutation(2).map { |p| p.zip(["c", "f"]) }

  # third mapping
  three = input.codes[1].tr(input.codes[0], "")
  permutations.map! { |p| p.push [three, "a"] }

  # fourth and fifth mapping
  four = input.codes[2].tr(input.codes[0], "").split("").permutation(2).to_a

  permutations.map! { |p| four.map { |f| p + f.zip(["b", "d"]) } }.flatten!(1)

  # sixth and seventh mapping
  codes = "abcdefg".tr(permutations[0].map(&:first).join, "").split("")
  answers = "abcdefg".tr(permutations[0].map(&:last).join, "").split("")
  pls = codes.permutation(2).map { |p| p.zip(answers) }

  permutations.map! { |p| [p + pls[0], p + pls[1]] }.flatten!(1)

  # solve
  permutations.each do |permutation|
    if input.codes.all? { |code| NUMBERS[code.tr(permutation.map(&:first).join, permutation.map(&:last).join).split("").sort.join] }
      return input.answer.map { |answer| NUMBERS[answer.tr(permutation.map(&:first).join, permutation.map(&:last).join).split("").sort.join] }
    end
  end
end
