defmodule Day1 do
  @behaviour Solution

  def solve_part_1(input) do
    expense_report = convert(input)

    for num_one <- expense_report,
        num_two <- expense_report do
      if num_one + num_two == 2020 do
        num_one * num_two
      end
    end
    |> Enum.find(&is_integer/1)
  end

  def solve_part_2(input) do
    expense_report = convert(input)

    for num_one <- expense_report,
        num_two <- expense_report,
        num_three <- expense_report do
      if num_one + num_two + num_three == 2020 do
        num_one * num_two * num_three
      end
    end
    |> Enum.find(&is_integer/1)
  end

  defp convert(input) do
    input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
  end
end
