require_relative "../../helper"

def input(filename, n)
  lines(__FILE__, filename).map do |line|
    l = line.split(" ")
    nums = l[1].match("x=(.+),y=(.+),z=(.+)")

    xrange = nums[1].split("..").map(&:to_i).to_range
    yrange = nums[2].split("..").map(&:to_i).to_range
    zrange = nums[3].split("..").map(&:to_i).to_range

    if xrange.between?(-n, n) && yrange.between?(-n, n) && zrange.between?(-n, n)
      Cube.new(l[0], xrange, yrange, zrange, n)
    end
  end.compact
end

class Array
  def to_range
    first..last
  end
end

class Range
  def subranges(other)
    inter = intersection(other)
    arr = [
      [min, other.min].min..(inter.min - 1),
      inter,
      (inter.max + 1)..[max, other.max].max
    ].select { |r| r.valid? && r.intersects?(self) }

    arr
  end

  def valid?
    first <= last
  end

  def intersection(other)
    return nil if max < other.min || other.max < min
    [min, other.min].max..[max, other.max].min
  end

  def intersects?(other)
    !!intersection(other)
  end

  def contains?(other)
    intersection(other) == other
  end

  def between?(a, b)
    !(max < a || min > b)
  end

  def clamp(a, b)
    [min, a].max..[max, b].min
  end
end

class Cube
  attr_reader :value, :xrange, :yrange, :zrange, :n

  def initialize(value, xrange, yrange, zrange, n)
    @value = value
    @xrange = xrange.clamp(-n, n)
    @yrange = yrange.clamp(-n, n)
    @zrange = zrange.clamp(-n, n)
    @n = n
  end

  def subtract(cube)
    cubes = []
    xrange.subranges(cube.xrange).each do |xr|
      yrange.subranges(cube.yrange).each do |yr|
        zrange.subranges(cube.zrange).each do |zr|
          subcube = Cube.new(value, xr, yr, zr, n)
          cubes << subcube unless cube.contains?(subcube)
        end
      end
    end
    cubes
  end

  def intersects?(cube)
    xrange.intersects?(cube.xrange) &&
    yrange.intersects?(cube.yrange) &&
    zrange.intersects?(cube.zrange)
  end

  def contains?(cube)
    xrange.contains?(cube.xrange) &&
    yrange.contains?(cube.yrange) &&
    zrange.contains?(cube.zrange)
  end

  def on?
    @value == "on"
  end

  def size
    xrange.size * yrange.size * zrange.size
  end
end

def solution(filename, n = 1_000_000)
  inputs = input(filename, n)

  hash = {}

  inputs.each do |input|
    hash[input] = 1 if input.on?
    hash.keys.each do |cube|
      next if cube == input
      if input.intersects?(cube)
        hash.delete(cube)
        cube.subtract(input).each do |subcube|
          hash[subcube] = 1
        end
      elsif input.contains?(cube)
        hash.delete(cube)
      end
    end
  end

  hash.keys.sum(&:size)
end
