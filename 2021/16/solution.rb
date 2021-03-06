require_relative "../../helper"

BITS = {
  "0" => "0000",
  "1" => "0001",
  "2" => "0010",
  "3" => "0011",
  "4" => "0100",
  "5" => "0101",
  "6" => "0110",
  "7" => "0111",
  "8" => "1000",
  "9" => "1001",
  "A" => "1010",
  "B" => "1011",
  "C" => "1100",
  "D" => "1101",
  "E" => "1110",
  "F" => "1111",
}

def input(filename)
  lines(__FILE__, filename).map do |line|
    line.split("").map { |bit| BITS[bit] }.join.split("")
  end
end

class BitString
  attr_reader :numbers, :length, :type_id, :children, :version

  def initialize(bits)
    @version = bits.shift(3).join.to_i(2)
    @type_id = bits.shift(3).join.to_i(2)
    @bits = bits
    @children = []
    @numbers = []
    @length_type_id = nil
    @length = 6

    if @type_id != 4
      @length_type_id = @bits.shift
      @length += 1
    end
  end

  def parse
    case @length_type_id
    when "1"
      count_subroutine
    when "0"
      length_subroutine
    else
      subroutine
    end
  end

  def version_sum
    @version + @children.sum(&:version_sum)
  end

  def all_numbers
    @children.each do |child|
      @numbers.push child.value
    end

    @numbers
  end

  def value
    numbers = all_numbers
    case @type_id
    when 0
      numbers.sum
    when 1
      numbers.inject(:*)
    when 2
      numbers.min
    when 3
      numbers.max
    when 4
      numbers.inject("") { |a, n| a + n.to_s(2).rjust(4, "0") }.to_i(2)
    when 5
      numbers[0] > numbers[1] ? 1 : 0
    when 6
      numbers[0] < numbers[1] ? 1 : 0
    when 7
      numbers[0] == numbers[1] ? 1 : 0
    end
  end

  def total_length
    @length + @children.sum(&:total_length)
  end

  private

  def length_subroutine
    length = @bits.shift(15).join.to_i(2)
    @length += 15

    while length > 0 do
      length -= parse_child.total_length
    end
  end

  def count_subroutine
    count = @bits.shift(11).join.to_i(2)
    @length += 11

    count.times { parse_child }
  end

  def parse_child
    BitString.new(@bits).tap do |packet|
      @children << packet
      packet.parse
    end
  end

  def subroutine
    while @bits.shift == "1" do
      @numbers.push @bits.shift(4).join("").to_i(2)
      @length += 5
    end

    @numbers.push @bits.shift(4).join("").to_i(2)
    @length += 5

    @numbers
  end
end

def solution(filename, type)
  input(filename).map do |bits|
    bit_string = BitString.new(bits)
    bit_string.parse
    bit_string.send(type)
  end
end
