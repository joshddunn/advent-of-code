require_relative "../../helper"

def input(filename)
  scanners = {}
  scanner = nil

  lines(__FILE__, filename).each do |line|
    next if line.empty?

    if number = line.match("--- scanner (.+) ---")
      scanner = number[1].to_i
      scanners[scanner] = []
    else
      x, y, z = line.split(",")
      scanners[scanner] << Vector.new(x, y, z)
    end
  end

  scanners
end

class Integer
  def degrees
    Math::PI * self / 180
  end
end

class Vector
  attr_accessor :x, :y, :z

  def initialize(x, y, z)
    @x = x.to_i
    @y = y.to_i
    @z = z.to_i
  end

  def magnitude
    Math.sqrt(x ** 2 + y ** 2 + z ** 2)
  end

  def name
    "#{x},#{y},#{z}"
  end

  def hash
    name.hash
  end

  def -(vec)
    Vector.new(x - vec.x, y - vec.y, z - vec.z)
  end

  def +(vec)
    Vector.new(x + vec.x, y + vec.y, z + vec.z)
  end

  def *(int)
    @x *= int
    @y *= int
    @z *= int
    self
  end

  def -@
    Vector.new(-x, -y, -z)
  end

  def manhattan(vec)
    (x - vec.x).abs + (y - vec.y).abs + (z - vec.z).abs
  end

  def rotate_x(theta)
    new_y = Math.cos(theta) * @y - Math.sin(theta) * @z
    new_z = Math.sin(theta) * @y + Math.cos(theta) * @z

    @y = new_y.round(0)
    @z = new_z.round(0)

    self
  end

  def rotate_y(theta)
    new_x = Math.cos(theta) * @x + Math.sin(theta) * @z
    new_z = - Math.sin(theta) * @x + Math.cos(theta) * @z

    @x = new_x.round(0)
    @z = new_z.round(0)

    self
  end

  def rotate_z(theta)

    new_x = Math.cos(theta) * @x - Math.sin(theta) * @y
    new_y = Math.sin(theta) * @x + Math.cos(theta) * @y

    @x = new_x.round(0)
    @y = new_y.round(0)

    self
  end

  def rotate(alpha, beta, gamma)
    rotate_x(alpha).rotate_y(beta).rotate_z(gamma)
    self
  end

  def eql?(other)
    other.kind_of?(self.class) && name == other.name
  end
end

def solution(filename)
  inputs = input(filename)

  scanners = { 0 => Vector.new(0, 0, 0) }

  (inputs.keys.length - 1).times do
    inputs.each do |key, input|
      next if scanners[key]

      scanners.keys.each do |scanner|

        hash1 = {}
        inputs[scanner].permutation(2).each do |permutation|
          vec1, vec2 = permutation
          hash1[[vec1, vec2]] = (vec1 - vec2).magnitude
        end

        hash2 = {}
        inputs[key].permutation(2).each do |permutation|
          vec1, vec2 = permutation

          hash2[[vec1, vec2]] = (vec1 - vec2).magnitude
        end

        overlap = (hash1.values & hash2.values).uniq

        next if overlap.count < 66 # 12 choose 2

        h1keys = hash1.key(overlap[0]).flatten.uniq
        h2keys = hash2.key(overlap[0]).flatten.uniq

        [90.degrees, 90.degrees, 90.degrees, 90.degrees].each do |tx|
          next if scanners[key]
          inputs[key].each { |v| v.rotate_x(tx) }

          [90.degrees, 90.degrees, 90.degrees, 90.degrees].each do |ty|
            next if scanners[key]
            inputs[key].each { |v| v.rotate_y(ty) }

            [90.degrees, 90.degrees, 90.degrees, 90.degrees].each do |tz|
              next if scanners[key]
              inputs[key].each { |v| v.rotate_z(tz) }

              h1keys.each do |h1key|
                h2keys.each do |h2key|
                  [h1key - h2key, h2key - h1key].each do |candidate|
                    [-1, 1].each do |direction|
                      intersection = inputs[key].map { |v| v + candidate * direction } & inputs[scanner]
                      if intersection.count >= 12
                        inputs[key].map! { |v| v + candidate * direction }
                        scanners[key] = candidate * direction
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  beacons = Hash.new(0)

  inputs.each do |key, vectors|
    vectors.each do |vector|
      beacons[vector.name] += 1
    end
  end

  max_manhattan = scanners.values.permutation(2).map { |permutation| permutation[0].manhattan(permutation[1]) }.max

  { beacons_count: beacons.keys.count, max_manhattan: max_manhattan }
end
