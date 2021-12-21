require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    l = line.match("Player (.+) starting position: (.+)")
    Position.new(l[1].to_i, l[2].to_i)
  end
end

class Position
  attr_reader :score, :position, :universes, :player

  def initialize(player, position)
    @player = player
    @position = position
    @score = 0
  end

  def move(x)
    @position += x
    @position = ((@position - 1) % 10) + 1
    @score += @position
    self
  end
end

class Die
  attr_reader :count

  def initialize
    @value = 0
    @count = 0
  end

  def roll
    @count += 1
    @value = @value % 100
    @value += 1
    @value
  end
end

def solution(filename)
  inputs = input(filename)

  die = Die.new

  while inputs.all? { |position| position.score < 1000 } do
    p = inputs.shift
    p.move(die.roll + die.roll + die.roll)
    inputs.push p
  end

  inputs.map(&:score).min * die.count
end

ROLLS = {
  3 => 1,
  4 => 3,
  5 => 6,
  6 => 7,
  7 => 6,
  8 => 3,
  9 => 1
}

def solution_two(a, b)
  cache = Hash.new(0)
  cache[[[0,0],[a,b]]] = 1

  which = 0

  winner = Hash.new(0)

  while cache.keys.any?
    new_cache = Hash.new(0)
    cache.each do |key, value|
      s, p = key
      ROLLS.each do |roll, universes|
        score = s.dup
        position = p.dup

        position[which] += roll
        position[which] = (position[which] - 1) % 10 + 1
        score[which] += position[which]

        if score[which] >= 21
          winner[which] += value * universes
        else
          new_cache[[score, position]] += value * universes
        end
      end
    end
    cache = new_cache
    which = which == 0 ? 1 : 0
  end

  winner.values.max
end
