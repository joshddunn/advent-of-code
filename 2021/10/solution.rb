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

def check_corrupted(input)
  stack = []
  corrupted = nil

  input.each do |char|
    case char
    when "(", "{", "[", "<"
      stack << char
    when ")"
      if stack.last == "("
        stack.pop
      else
        corrupted = ")"
        break
      end
    when "}"
      if stack.last == "{"
        stack.pop
      else
        corrupted = "}"
        break
      end
    when "]"
      if stack.last == "["
        stack.pop
      else
        corrupted = "]"
        break
      end
    when ">"
      if stack.last == "<"
        stack.pop
      else
        corrupted = ">"
        break
      end
    end
  end

  { stack: stack, corrupted: corrupted }
end

def completed(stack)
  answer = []

  stack.reverse.each do |item|
    case item
    when "("
      answer << ")"
    when "{"
      answer << "}"
    when "<"
      answer << ">"
    when "["
      answer << "]"
    end
  end

  answer
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
