require 'pry'

def input(filename)
  File.read("#{File.dirname(__FILE__)}/#{filename}").split("\n").map do |line|
    # put stuff here
    line
  end
end

def solution(filename)
  inputs = input(filename)
end
