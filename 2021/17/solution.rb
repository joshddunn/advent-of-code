require_relative "../../helper"

def input(filename)
  matches = lines(__FILE__, filename).first.match(/x=(.+)\.\.(.+), y=(.+)\.\.(.+)/)
  { x_range: matches[1].to_i..matches[2].to_i, y_range: matches[3].to_i..matches[4].to_i }
end

class Trajectory
  attr_reader :success, :max_height, :initial

  def initialize(dx, dy, target)
    @x = 0
    @y = 0
    @dx = dx
    @dy = dy
    @initial = [dx, dy]
    @target = target
    @trajectory = [[@x, @y]]
    @max_height = @y
    @success = false
  end

  def shoot!
    while true do
      @x += @dx
      @y += @dy

      @dx -= @dx == 0 ? 0 : @dx / @dx.abs
      @dy -= 1

      @trajectory << [@x, @y]
      @max_height = @y if @y > @max_height

      # early returns for impossible solutions
      break if @dx == 0 && !@target[:x_range].include?(@x)
      break if @y < @target[:y_range].min && @dy < 0

      # success metric
      if @target[:x_range].include?(@x) && @target[:y_range].include?(@y)
        @success = true
        break
      end
    end
  end
end

def solution(filename, alternate = false)
  target = input(filename)

  trajectories = []

  (1..500).each do |dx|
    puts dx if dx % 100 == 0
    (target[:y_range].min..500).each do |dy|
      trajectory = Trajectory.new(dx, dy, target)
      trajectory.shoot!
      trajectories << trajectory if trajectory.success
    end
  end

  alternate ? trajectories.count : trajectories.max_by(&:max_height).max_height
end
