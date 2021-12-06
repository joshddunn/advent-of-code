defmodule Solution do
  def input(filename) do
    path = __ENV__.file |> String.replace(~r/\/[A-Za-z\.]+$/, "")
    {:ok, file} = File.read("#{path}/#{filename}")

    file
    |> String.trim
    |> String.split("\n")
  end

  def solution_one(filename) do
    inputs = input(filename)

    length = inputs |> Enum.at(0) |> String.length

    { bits } = inputs
    |> Enum.reduce({ List.duplicate(0, length) }, fn input, { bits } ->
      { new_bits } = input
      |> String.split("", trim: true)
      |> Enum.with_index(0)
      |> Enum.reduce({ bits }, fn { bit, index }, { bits } ->
        { bits |> List.update_at(index, &(&1 + if bit == "1", do: 1, else: -1)) }
      end)

      { new_bits }
    end)

    gamma_rate = bits
    |> Enum.map(fn bit -> if bit >= 0, do: "1", else: "0" end)
    |> Enum.join("")
    |> String.to_integer(2)

    epsilon_rate = bits
    |> Enum.map(fn bit -> if bit >= 0, do: "0", else: "1" end)
    |> Enum.join("")
    |> String.to_integer(2)

    gamma_rate * epsilon_rate
  end

  def most_common_value(inputs, index) do
    if inputs |> length == 1 do
      inputs |> Enum.at(0)
    else
      grouped = inputs |> Enum.group_by(&String.at(&1, index))
      new_inputs = if length(grouped["1"] || []) >= length(grouped["0"] || []), do: grouped["1"], else: grouped["0"]
      most_common_value(new_inputs, index + 1)
    end
  end

  def least_common_value(inputs, index) do
    if inputs |> length == 1 do
      inputs |> Enum.at(0)
    else
      grouped = inputs |> Enum.group_by(&String.at(&1, index))
      new_inputs = if length(grouped["0"] || []) <= length(grouped["1"] || []), do: grouped["0"], else: grouped["1"]
      least_common_value(new_inputs, index + 1)
    end
  end

  def solution_two(filename) do
    inputs = input(filename)

    oxygen_generator_rating = most_common_value(inputs, 0) |> String.to_integer(2)
    co2_scrubber_rating = least_common_value(inputs, 0) |> String.to_integer(2)

    oxygen_generator_rating * co2_scrubber_rating
  end
end

IO.puts Solution.solution_one("example.txt")
IO.puts Solution.solution_one("input.txt")
IO.puts Solution.solution_two("example.txt")
IO.puts Solution.solution_two("input.txt")
