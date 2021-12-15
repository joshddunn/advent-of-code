require_relative "../../helper"
require 'rgl/adjacency'
require 'rgl/dijkstra'

include RGL

def input(filename)
  lines(__FILE__, filename).map do |row|
    row.split("").map(&:to_i)
  end
end

def solution(filename, alternate = false)
  inputs = input(filename)

  if alternate
    inputs.map! do |row|
      new_row = []
      5.times do |iter|
        row.each do |val|
          new_row << (val + iter - 1) % 9 + 1
        end
      end
      new_row
    end

    new_inputs = []
    5.times do |iter|
      inputs.each do |row|
        new_inputs << row.map do |val|
          (val + iter - 1) % 9 + 1
        end
      end
    end

    inputs = new_inputs
  end

  width = inputs[0].length
  height = inputs.length

  graph = RGL::DirectedAdjacencyGraph.new

  vertices = []
  inputs.each_with_index do |row, j|
    row.each_with_index do |_, i|
      vertices << "#{i},#{j}"
    end
  end

  graph.add_vertices(*vertices)

  edge_weights = {}

  inputs.each_with_index do |row, j|
    row.each_with_index do |_, i|

      [[1, 0], [-1, 0], [0, 1], [0, -1]].each do |dxdy|
        dx, dy = dxdy

        x = i + dx
        y = j + dy

        next if x < 0 || y < 0 || x >= width || y >= height

        edge_weights[[[i, j].join(","), [x, y].join(",")]] = inputs[y][x]
        graph.add_edge([i, j].join(","), [x, y].join(","))
      end
    end
  end

  dijkstra = DijkstraAlgorithm.new(graph, edge_weights, DijkstraVisitor.new(graph))

  dijkstra.shortest_path("0,0", "#{width - 1},#{height - 1}")[1..-1].sum do |val|
    x, y = val.split(",").map(&:to_i)
    inputs[y][x]
  end
end
