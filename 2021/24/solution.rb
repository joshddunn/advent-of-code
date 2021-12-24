require_relative "../../helper"

def input(filename)
  blocks = []
  block = []

  lines(__FILE__, filename).each do |line|
    if line.include?("inp") && block.any?
      blocks << block
      block = []
    end

    block << line.split(" ")
  end

  blocks << block

  blocks
end

def step(input, z, nums, num)
  tmp = Hash.new(0)
  tmp["z"] = z

  input.each do |instruction|
    action, arg1, arg2 = instruction

    arg2 = arg2.match?("[a-z]") ? tmp[arg2] : arg2.to_i unless arg2.nil?

    case action
    when "inp"
      tmp[arg1] = num
    when "add"
      tmp[arg1] += arg2
    when "mul"
      tmp[arg1] *= arg2
    when "div"
      tmp[arg1] /= arg2
    when "mod"
      tmp[arg1] %= arg2
    when "eql"
      tmp[arg1] = tmp[arg1] == arg2 ? 1 : 0
    end
  end

  tmp["z"]
end

def solution(filename, which = :<)
  inputs = input(filename)

  cache = {0 => ""}

  inputs.each do |input|
    new_cache = {}

    cache.each do |z, nums|
      (1..9).each do |num|
        new_z = step(input, z, nums, num)
        new_nums = "#{nums}#{num}"
        if new_cache[new_z]
          new_cache[new_z] = new_nums if new_nums.send(which, new_cache[new_z])
        else
          new_cache[new_z] = new_nums if z < 100_000 # lol wat
        end
      end
    end

    cache = new_cache
  end

  cache[0].to_i
end
