defmodule Solution do
  def input(filename) do
    path = __ENV__.file |> String.replace(~r/\/[A-Za-z\.]+$/, "")
    {:ok, file} = File.read("#{path}/#{filename}")

    file
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line ->
      split = line |> String.split(" ")
      [ direction: split |> Enum.at(0), amount: split |> Enum.at(1) |> String.to_integer ]
    end)
  end

  def solution_one(filename) do
    inputs = input(filename)

    { horizontal, depth } = inputs
    |> Enum.reduce({ 0, 0 }, fn input, { depth, horizontal } ->
      case input[:direction] do
        "up" -> { depth - input[:amount], horizontal }
        "down" -> { depth + input[:amount], horizontal }
        "forward" -> { depth, horizontal + input[:amount] }
      end
    end)

    horizontal * depth
  end

  def solution_two(filename) do
    inputs = input(filename)

    { horizontal, depth, _aim } = inputs
    |> Enum.reduce({ 0, 0, 0 }, fn input, { depth, horizontal, aim } ->
      case input[:direction] do
        "up" -> { depth, horizontal, aim - input[:amount] }
        "down" -> { depth, horizontal, aim + input[:amount] }
        "forward" -> { depth + aim * input[:amount], horizontal + input[:amount], aim }
      end
    end)

    horizontal * depth
  end
end

IO.puts Solution.solution_one("example.txt")
IO.puts Solution.solution_one("input.txt")
IO.puts Solution.solution_two("example.txt")
IO.puts Solution.solution_two("input.txt")
