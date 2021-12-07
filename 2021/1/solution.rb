require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map(&:to_i)
end

def sonar_sweep(filename, window = 1)
  values = input(filename)

  count = 0

  values.length.times do |index|
    next if index < window
    window_one = values[(index - window)..(index - 1)].sum
    window_two = values[(index - window + 1)..index].sum
    count += 1 if window_two > window_one
  end

  count
end
