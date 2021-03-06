require_relative "../../helper"

def input(filename)
  lines(__FILE__, filename).map { |line| eval(line) }
end

class Tree
  attr_accessor :left, :right, :parent, :value, :splitted

  def initialize(value = nil, parent = nil)
    @value = value
    @parent = parent
    @splitted = false
  end

  def add_left(left)
    if left.is_a? Integer
      @left = Tree.new(left, self)
    else
      @left = Tree.new(nil, self)
      @left.add_left left[0]
      @left.add_right left[1]
    end
  end

  def add_right(right)
    if right.is_a? Integer
      @right = Tree.new(right, self)
    else
      @right = Tree.new(nil, self)
      @right.add_left right[0]
      @right.add_right right[1]
    end
  end

  def reduce
    if should_explode?
      explode!
      reduce
    end

    top.splitted = false
    if should_split?
      split!
      reduce
    end
  end

  def split!
    return if top.splitted
    return if top.should_explode?

    if @value && @value >= 10
      add_left @value / 2
      add_right @value - @value / 2
      @value = nil
      top.splitted = true
    else
      @left&.split!
      @right&.split!
    end
  end

  def is_array?
    @left&.value && @right&.value
  end

  def explode!
    return if @value


    if depth < 4
      @left.explode!
      @right.explode!
    else
      @left.explode if @left.is_array?
      @right.explode if @right.is_array?
    end
  end

  def explode
    if l = left_item
      l.value += @left.value
    end

    if r = right_item
      r.value += @right.value
    end

    @value = 0
    @right = nil
    @left = nil
  end

  def left_ascend(item)
    if @left == item
      @parent&.left_ascend(self)
    else
      @left.right_traverse
    end
  end

  def right_ascend(item)
    if @right == item
      @parent&.right_ascend(self)
    else
      @right.left_traverse
    end
  end

  def left_traverse
    return self if @value
    @left.left_traverse
  end

  def right_traverse
    return self if @value
    @right.right_traverse
  end

  def left_item
    @parent.left_ascend(self)
  end

  def right_item
    @parent.right_ascend(self)
  end

  def print
    return @value if @value

    arr = []
    arr.push @left.print
    arr.push @right.print
  end

  def multiply
    return @value if @value
    3 * @left.multiply + 2 * @right.multiply
  end

  def should_explode?
    return false if @value
    return true if depth > 4
    @left.should_explode? || @right.should_explode?
  end

  def should_split?
    return false if top.splitted
    return @value >= 10 if @value
    @left.should_split? || @right.should_split?
  end

  def depth
    return 1 if @parent.nil?
    @parent.depth + 1
  end

  def top
    return self if @parent.nil?
    @parent.top
  end
end

def solution(filename)
  inputs = input(filename)

  start = inputs.shift
  tree = nil

  inputs.map do |input|
    tree = Tree.new

    tree.add_left start
    tree.add_right input

    tree.reduce

    start = tree.print
  end

  tree.multiply
end

def solution_sums(filename)
  inputs = input(filename)

  inputs.map do |input|
    left, right = input

    tree = Tree.new

    tree.add_left left
    tree.add_right right

    tree.reduce

    tree.multiply
  end
end

def solution_magnitude(filename)
  inputs = input(filename)

  max = 0

  inputs.each_with_index do |left, x|
    inputs.each_with_index do |right, y|
      next if x == y

      tree = Tree.new
      tree.add_left left
      tree.add_right right

      tree.reduce

      max = tree.multiply if tree.multiply > max
    end
  end

  max
end
