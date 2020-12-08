defmodule Day7 do
  @behaviour Solution

  @rule_pattern ~r/(?<color>.*?) bags contain (?<contents>.*)./
  @contents_pattern ~r/(?<count>\d+) (?<color>.*) bags?/

  def solve_part_1(input) do
    input
    |> rules()
    |> containers()
    |> parent_count("shiny gold")
    |> Enum.uniq()
    |> length()
  end

  def solve_part_2(input) do
    input
    |> rules()
    |> child_count("shiny gold")
  end

  defp rules(input) do
    input
    |> String.split("\n", trim: true)
    |> Map.new(fn line ->
      rule = Regex.named_captures(@rule_pattern, line)

      contents =
        case rule["contents"] do
          "no other bags" ->
            []

          contents ->
            contents
            |> String.split(", ")
            |> Enum.map(&Regex.named_captures(@contents_pattern, &1))
            |> Enum.map(&{String.to_integer(&1["count"]), &1["color"]})
        end

      {rule["color"], contents}
    end)
  end

  defp containers(rules) do
    rules
    |> Enum.flat_map(fn {container, bags} ->
      Enum.map(bags, fn {_count, bag} -> {bag, container} end)
    end)
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
  end

  defp parent_count(containers, color, colors \\ []) do
    containers
    |> Map.get(color)
    |> case do
      nil -> colors
      parents -> Enum.flat_map(parents, &parent_count(containers, &1, [&1 | colors]))
    end
  end

  defp child_count(rules, color) do
    rules
    |> Map.get(color)
    |> case do
      [] ->
        0

      children ->
        children
        |> Enum.map(fn {count, color} -> count + count * child_count(rules, color) end)
        |> Enum.sum()
    end
  end
end
