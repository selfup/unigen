defmodule Unigen do
  @moduledoc """
    Builds singular and clusters of universes
  """

  @doc ~S"""
    ## Examples
    iex> is_list(Unigen.planes(0))
    true
  """
  @spec planes(number) :: List[Map]
  def planes(n) do
    Enum.to_list(
      0..n
      |> Enum.map(fn x ->
        Enum.to_list(
          0..n
          |> Enum.map(fn y ->
            Enum.to_list(
              0..n
              |> Enum.map(fn z ->
                Generator.generate(x, y, z)
              end)
            )
          end)
        )
      end)
    )
  end

  @doc ~S"""
    ## Examples
    iex> is_map(Unigen.build(0))
    true
  """
  @spec build(number) :: Map
  def build(limit) do
    planes(limit)
    |> List.flatten()
    |> Enum.map(&Analyzer.set_charge(&1))
    |> Analyzer.field_charge(limit)
  end

  @doc ~S"""
    ## Examples
    iex> is_list(Unigen.generate(0))
    true
  """
  @spec generate(number) :: List[Map]
  def generate(limit) do
    %{charge: charge, universe: universe} = build(limit)
    IO.puts("#{length(universe)} - #{charge}\n")
    universe
  end

  @doc ~S"""
    ## Examples
    iex> is_list(Unigen.strategy(0, 0, true))
    true
  """
  @spec strategy(number, number, boolean) :: List[Map]
  def strategy(limit, idx, incremental) do
    if incremental do
      generate(idx)
    else
      generate(limit)
    end
  end

  @doc ~S"""
    ## Examples
    iex> is_list(Unigen.deploy_clusters(5, true))
    true
    iex> is_list(Unigen.deploy_clusters(5, false))
    true
  """
  @spec deploy_clusters(number, boolean) :: List[Map]
  def deploy_clusters(limit, incremental) do
    1..limit
    |> Task.async_stream(fn idx -> strategy(limit, idx, incremental) end,
      timeout: :infinity,
      max_concurrency: 16
    )
    |> Enum.map(fn {:ok, universe} -> universe end)
  end
end
