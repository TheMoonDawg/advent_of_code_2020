defmodule Day2 do
  @behaviour Solution

  def solve_part_1(input) do
    input
    |> convert()
    |> Enum.reduce(0, fn {min, max, policy, password}, acc ->
      letters = String.codepoints(password)

      sum =
        Enum.reduce(letters, 0, fn letter, acc ->
          if letter == policy do
            acc + 1
          else
            acc
          end
        end)

      if sum >= min and sum <= max do
        acc + 1
      else
        acc
      end
    end)
  end

  def solve_part_2(input) do
    input
    |> convert()
    |> Enum.reduce(0, fn {pos_1, pos_2, policy, password}, acc ->
      char_1 = String.at(password, pos_1 - 1)
      char_2 = String.at(password, pos_2 - 1)

      cond do
        char_1 == policy and char_2 == policy -> acc
        char_1 != policy and char_2 != policy -> acc
        true -> acc + 1
      end
    end)
  end

  defp convert(input) do
    input
    |> String.split("\n")
    |> List.delete("")
    |> Enum.map(fn str ->
      parts = String.split(str)

      min_max =
        parts
        |> Enum.at(0)
        |> String.split("-")
        |> Enum.map(&String.to_integer/1)

      min = Enum.at(min_max, 0)
      max = Enum.at(min_max, 1)
      policy = Enum.at(parts, 1)
      password = Enum.at(parts, 2)

      {min, max, String.at(policy, 0), password}
    end)
  end
end
