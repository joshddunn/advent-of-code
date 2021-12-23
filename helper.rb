require 'pry'
require 'set'
require 'colorize'
require 'rgl/adjacency'
require 'rgl/dijkstra'
require 'algorithms'

include RGL

def spec(actual, expected)
  if actual == expected
    puts "success"
  else
    puts "failed: got #{actual} expected #{expected}"
  end
end

def lines(source, filename)
  File.read("#{File.dirname(source)}/#{filename}").split("\n")
end

class Counter
  attr_reader :items

  def initialize
    @items = Hash.new(0)
  end

  def add(key)
    @items[key] += 1
  end
end

class Array
  def self.from_coordinates(coordinates)
    max_x = coordinates.map(&:first).max
    max_y = coordinates.map(&:last).max

    Array.new(max_y + 1) { Array.new(max_x + 1, 0) }.tap do |array|
      coordinates.each do |point|
        array[point[1]][point[0]] += 1
      end
    end
  end

  def print
    puts ""
    self.each do |row|
      puts row.map { |p| p.positive? ? " ".on_white : " " }.join
    end
  end
end

class Dijkstra
  def initialize
    @graph = RGL::DirectedAdjacencyGraph.new
    @weights = {}
    @vertices = Set.new
  end

  def add_edge(from, to, weight)
    @weights[[from, to]] = weight
    @graph.add_edge from, to
  end

  def dijkstra
    DijkstraAlgorithm.new(@graph, @weights, DijkstraVisitor.new(@graph))
  end

  def shortest_path(from, to)
    dijkstra.shortest_path(from, to)
  end
end
