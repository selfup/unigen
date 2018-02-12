defmodule Analyzer do
  @moduledoc """
    Analyses Universe
  """

  @spec sum_protons(Map) :: number
  def sum_protons(universe) do
    Enum.reduce(universe, 0, fn(block, acc) ->
      block[:atom][:nucleus][:protons] + acc
    end)
  end

  @spec sum_electrons(Map) :: number
  def sum_electrons(universe) do
    Enum.reduce(universe, 0, fn(block, acc) ->
      block[:atom][:electrons] + acc
    end)
  end

  @spec output_charge(Map, Map) :: %{charge: String, universe: Map}
  def output_charge(%{e: e, p: p, s: s}, universe) do
    cond do
      (p == s) && (e == s) -> %{charge: "neutral", universe: universe}
      (p > s) && (e < p) -> %{charge: "ionic", universe: universe}
      true -> %{charge: "anionic", universe: universe}
    end
  end

  @spec field_charge(Map, number) :: %{charge: String, universe: Map}
  def field_charge(universe, limit) do
    size = (limit + 1) * (limit + 1) * (limit + 1)
    options = %{p: sum_protons(universe), e: sum_electrons(universe), s: size}
    output_charge(options, universe)
  end

  @spec set_charge(Map) :: Map
  def set_charge(block) do
    cond do
      block[:atom][:nucleus][:protons] > block[:atom][:electrons] ->
        Map.put(block, :charge, 1)
      block[:atom][:nucleus][:protons] < block[:atom][:electrons] ->
        Map.put(block, :charge, -1)
      true -> block
    end
  end
end
