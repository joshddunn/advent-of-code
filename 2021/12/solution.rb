require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split('-')
  end
end

class Cave
  attr_reader :name, :connections

  def initialize(name)
    @name = name
    @connections = Set.new
  end

  def add_connection(connection)
    @connections.add connection
  end
end

def traverse(cave, alternate, counter = Hash.new(0), queue = [])
  queue.push cave.name
  counter[cave.name] += 1 if cave.name.downcase == cave.name

  return [queue] if cave.name == "end"

  queues = []

  cave.connections.each do |connection|
    name = connection.name
    if name.downcase != name || !counter.has_key?(name)
      queues.concat traverse(connection, alternate, counter.dup, queue.dup)
    elsif alternate && name.downcase == name && name != "start" && name != "end" && counter.values.max < 2
      queues.concat traverse(connection, alternate, counter.dup, queue.dup)
    end
  end

  queues
end

def solution(filename, alternate = false)
  inputs = input(filename)

  caves = {}

  inputs.each do |input|
    caves[input[0]] = Cave.new(input[0]) unless caves[input[0]]
    caves[input[1]] = Cave.new(input[1]) unless caves[input[1]]

    caves[input[0]].add_connection caves[input[1]]
    caves[input[1]].add_connection caves[input[0]]
  end

  traverse(caves["start"], alternate).count
end
