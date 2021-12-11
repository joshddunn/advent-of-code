require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map.with_index do |line|
    line.split("").map(&:to_i)
  end
end

def flash(octos, queue, flashes = 0)
  flashes += queue.length

  new_queue = []

  queue.each do |octo|
    (-1..1).each do |dx|
      (-1..1).each do |dy|
        next if dx.zero? && dy.zero?

        x = octo[:x] + dx
        y = octo[:y] + dy

        next if x < 0 || y < 0 || x >= octos[0].length || y >= octos.length

        octos[x][y] += 1

        new_queue << { x: x, y: y } if octos[x][y] == 10
      end
    end
  end

  new_queue.length.zero? ? flashes : flash(octos, new_queue, flashes)
end

def solution(filename, iterations = 100)
  octos = input(filename)

  flashes = 0
  iter = 0

  while iter < iterations do
    octos.each_with_index do |row, x|
      row.each_with_index do |_, y|
        octos[x][y] += 1
      end
    end

    queue = []

    octos.each_with_index do |row, x|
      row.each_with_index do |octo, y|
        queue << { x: x, y: y } if octo == 10
      end
    end

    flashes += flash(octos, queue)

    octos.each_with_index do |row, x|
      row.each_with_index do |_, y|
        octos[x][y] = 0 if octos[x][y] > 9
      end
    end

    iter += 1

    return iter if octos.sum(&:sum).zero?
  end

  flashes
end
