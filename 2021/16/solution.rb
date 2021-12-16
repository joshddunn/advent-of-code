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
    @length_type_id = @type_id == 4 ? nil : bits.shift
    @bits = bits
    @children = []
    @length = 0
    @numbers = []
  end

  def parse
    case @length_type_id
    when "1"
      count_subroutine
    when "0"
      length_subroutine
    else
      four_subroutine
    end
  end

  def version_sum
    @version + @children.sum(&:version_sum)
  end

  private

  def length_subroutine
    length = @bits.shift(15).join.to_i(2)

    while length > 0 do
      packet = BitString.new(@bits)
      @children << packet
      packet.parse
      length -= packet.length
    end
  end

  def count_subroutine
    count = @bits.shift(11).join.to_i(2)

    count.times do
      packet = BitString.new(@bits)
      @children << packet
      packet.parse
    end
  end

  def four_subroutine
    @length += 6

    while @bits.shift == "1" do
      @numbers.concat @bits.shift(4)
      @length += 5
    end

    @numbers.concat @bits.shift(4)
    @length += 5

    @numbers
  end
end

def solution(filename)
  input(filename).map do |bits|
    bit_string = BitString.new(bits)
    bit_string.parse
    bit_string.version_sum
  end
end

# spec solution("example.txt"), [16, 12, 23, 31]
# spec solution("input.txt"), [1012]
spec solution("example_two.txt"), [3, 54, 7, 9, 1, 0, 0, 1]
# spec solution("input.txt"), 0
