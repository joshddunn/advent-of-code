require_relative "../../helper"

CAVE_MAPPING = [
  "A",
  "B",
  "C",
  "D"
]

CAVE_INDEX = {
  "A" => 0,
  "B" => 1,
  "C" => 2,
  "D" => 3
}

CAVE_OPENINGS = [2, 4, 6, 8]

POINT_MULTIPLIERS = {
  "A" => 1,
  "B" => 10,
  "C" => 100,
  "D" => 1000
}

class Array
  def deep_dup
    map { |ar| ar.dup }
  end

  def to_range
    first..last
  end
end

class Cave
  attr_reader :caves, :hallway, :sum, :size

  def initialize(parent, caves, hallway, size, sum = 0)
    @caves = caves
    @hallway = hallway
    @size = size
    @paasum = sum
    @sum = sum
    @parent = parent
  end

  def solved?
    caves.all? { |cave| cave.length == size && cave.all? { |c| c.include?("x") } }
  end

  def unsolved?
    !solved?
  end

  def permutations
    permutations = []

    hallway.each_with_index do |h, hi|
      next if h.nil? || h == "X"

      ci = CAVE_INDEX[h]

      next unless hallway[[hi, CAVE_OPENINGS[ci]].sort.to_range].reject { |h| h.nil? || h == "X" }.count == 1
      next unless caves[ci].all? { |c| c.include?("x") }

      new_caves = caves.deep_dup
      new_hallway = hallway.dup

      val = new_hallway[hi]
      new_caves[ci] << "#{val}x"
      new_hallway[hi] = nil

      points = (size - new_caves[ci].length) + (hi - CAVE_OPENINGS[ci]).abs + 1

      permutations << Cave.new(self, new_caves, new_hallway, size, sum + points * POINT_MULTIPLIERS[val])
    end

    caves.each_with_index do |c, ci|
      next if c.all? { |cc| cc.include?("x") }
      hallway.each_with_index do |h, hi|
        next unless h.nil?
        next unless hallway[[hi, CAVE_OPENINGS[ci]].sort.to_range].all? { |h| h.nil? || h == "X" }

        new_caves = caves.deep_dup
        new_hallway = hallway.dup

        val = new_caves[ci].pop
        new_hallway[hi] = val

        points = (size - c.length) + (hi - CAVE_OPENINGS[ci]).abs + 1

        permutations << Cave.new(self, new_caves, new_hallway, size, sum + points * POINT_MULTIPLIERS[val])
      end
    end

    permutations
  end

  def key
    "#{caves.inspect} #{hallway.inspect}"
  end
end

def solution(filename)
  caves = [
    ["D", "D"],
    ["C", "A"],
    ["B", "C"],
    ["B", "A"]
  ]

  hallway = [nil, nil, "X", nil, "X", nil, "X", nil, "X", nil, nil]

  pqueue = MinPriorityQueue.new

  cave = Cave.new(nil, caves, hallway, caves[0].length)
  pqueue.push cave, cave.sum

  seen = {}

  while (cave = pqueue.pop).unsolved? do
    puts cave.sum

    cave.permutations.each do |permutation|
      next if seen[permutation.key]
      seen[permutation.key] = cave
      pqueue.push permutation, permutation.sum
    end
  end

  cave.sum
end

spec solution("example.txt"), 0
# spec solution("input.txt"), 0
# spec solution("example.txt"), 0
# spec solution("input.txt"), 0
