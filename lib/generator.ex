defmodule Generator do
  @moduledoc """
    Generates a universe block
  """

  @spec generate(number, number, number) :: Map
  def generate(x, y, z) do
    %{
      x: x,
      y: y,
      z: z,
      charge: 0,
      atom: %{
        electrons: Enum.random(0..118),
        nucleus: %{
          protons: Enum.random(0..118),
          neutrons: Enum.random(0..118)
        }
      }
    }
  end
end
