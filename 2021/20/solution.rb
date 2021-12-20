require_relative "../../helper"

def input(filename)
  l = lines(__FILE__, filename)
  algorithm = l.shift
  l.shift

  map = Hash.new(".")
  l.each_with_index do |line, row|
    line.split("").each_with_index do |val, col|
      map[[col, row]] = val
    end
  end

  { algorithm: algorithm, map: map, n: l[0].length }
end

def solution(filename, iter = 2)
  inputs = input(filename)

  map = inputs[:map]

  right = inputs[:n] + 1
  left = -1

  iter.times do |t|
    new_map = Hash.new(inputs[:algorithm][(map[[-200,-200]] * 9).split("").map { |s| s == "#" ? "1" : "0" }.join.to_i(2)])

    (left..right).each do |x|
      (left..right).each do |y|
        str = []
        str << map[[x - 1, y - 1]]
        str << map[[x    , y - 1]]
        str << map[[x + 1, y - 1]]

        str << map[[x - 1, y]]
        str << map[[x    , y]]
        str << map[[x + 1, y]]

        str << map[[x - 1, y + 1]]
        str << map[[x    , y + 1]]
        str << map[[x + 1, y + 1]]

        index = str.map { |s| s == "#" ? "1" : "0" }.join("").to_i(2)

        new_map[[x, y]] = inputs[:algorithm][index]
      end
    end

    right += 1
    left -= 1

    map = new_map
  end

  map.select { |k, v| v == "#" }.count
end
