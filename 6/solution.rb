require 'pry'

def input(filename)
  file = File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n")
  file.shift.split(": ").last.split(",").map(&:to_i)
end

class LanternFish
  attr_reader :timer, :number

  def initialize(timer, number)
    @timer = timer
    @number = number
  end

  def decrement
    @timer -= 1
    @timer < 0 ? reproduce : 0
  end

  # lol
  private def reproduce
    @timer = 6
    @number
  end
end

def solution(filename, days)
  fishes = input(filename).map { |timer| LanternFish.new(timer, 1) }

  (1..days).each do |day|
    fishes << LanternFish.new(8, fishes.sum(&:decrement))
  end

  fishes.sum(&:number)
end
