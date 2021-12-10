require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).first.split(",").map(&:to_i)
end

class LanternFishSchool
  attr_reader :timer, :number

  def initialize(timer, number)
    @timer = timer
    @number = number
  end

  def decrement
    @timer -= 1
    @timer < 0 ? reproduce : 0
  end

  private def reproduce
    @timer = 6
    @number
  end
end

def solution(filename, days)
  fishes = input(filename).map { |timer| LanternFishSchool.new(timer, 1) }
  days.times { |day| fishes << LanternFishSchool.new(8, fishes.sum(&:decrement)) }
  fishes.sum(&:number)
end

#############
# code golf #
#############

def solution_golf(filename, days)
  fishes = Array.new(9, 0)
  input(filename).each { |timer| fishes[timer] += 1 }
  days.times { fishes.rotate!(1)[6] += fishes[8] }
  fishes.sum
end
