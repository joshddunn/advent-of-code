require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split('-')
  end
end

class List
  attr_reader :point, :connections

  def initialize(point, connection)
    @point = point
    @connections = Set.new([connection])
  end

  def add_connection(connection)
    @connections.add connection
  end
end

def traverse(cave, point, alternate, counter = Hash.new(0), queue = [])
  queue.push point.point
  counter[point.point] += 1 if point.point.downcase == point.point

  return [queue] if point.point == "end"

  queues = []

  point.connections.each do |connection|
    if connection.downcase != connection || !counter.has_key?(connection)
      queues.concat traverse(cave, cave[connection], alternate, counter.dup, queue.dup)
    elsif alternate && connection.downcase == connection && connection != "start" && connection != "end" && counter.values.max < 2
      queues.concat traverse(cave, cave[connection], alternate, counter.dup, queue.dup)
    end
  end

  queues
end

def solution(filename, alternate = false)
  inputs = input(filename)

  cave = {}

  inputs.each do |input|
    if cave[input[0]]
      cave[input[0]].add_connection(input[1])
    else
      cave[input[0]] = List.new(input[0], input[1])
    end

    if cave[input[1]]
      cave[input[1]].add_connection(input[0])
    else
      cave[input[1]] = List.new(input[1], input[0])
    end
  end

  traverse(cave, cave["start"], alternate).count
end
