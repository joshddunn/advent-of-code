defmodule Solution do
  def input(filename) do
    path = __ENV__.file |> String.replace(~r/\/[A-Za-z\.]+$/, "")
    {:ok, file} = File.read("#{path}/#{filename}")

    file
    |> String.trim
    |> String.split("\n")
    |> Enum.map(fn line ->
      line |> String.to_integer
    end)
  end

  def solution(filename, window) do
    values = input(filename)

    values
    |> Enum.with_index(0)
    |> Enum.filter(fn { _, index } ->
      if index < window do
        false
      else
        window_one = values |> Enum.slice(index - window, window) |> Enum.sum
        window_two = values |> Enum.slice(index - window + 1, window) |> Enum.sum
        window_two > window_one
      end
    end)
    |> length
  end
end

IO.puts Solution.solution("example.txt", 1)
IO.puts Solution.solution("input.txt", 1)
IO.puts Solution.solution("example.txt", 3)
IO.puts Solution.solution("input.txt", 3)
