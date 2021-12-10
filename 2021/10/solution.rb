require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split("")
  end
end

POINTS_ONE = {
  ")" => 3,
  "]" => 57,
  "}" => 1197,
  ">" => 25137
}

POINTS_TWO = {
  ")" => 1,
  "]" => 2,
  "}" => 3,
  ">" => 4
}

MATCHES = {
  ")" => "(",
  "]" => "[",
  "}" => "{",
  ">" => "<"
}

def check_corrupted(input)
  stack = []
  corrupted = nil

  input.each do |char|
    if MATCHES[char]
      if stack.last == MATCHES[char]
        stack.pop
      else
        corrupted = char
        break
      end
    else
      stack << char
    end
  end

  { stack: stack, corrupted: corrupted }
end

def completed(stack)
  stack.reverse.map { |char| MATCHES.key(char) }
end

def solution(filename, alternate = false)
  inputs = input(filename)

  if alternate
    sums = inputs.
      map { |input| check_corrupted(input) }.
      reject { |answer| answer[:corrupted] }.
      map { |answer| completed(answer[:stack]).inject(0) { |sum, bracket| sum * 5 + POINTS_TWO[bracket] } }.
      sort

    sums[sums.length / 2]
  else
    inputs.sum { |input| POINTS_ONE[check_corrupted(input)[:corrupted]] || 0 }
  end
end
