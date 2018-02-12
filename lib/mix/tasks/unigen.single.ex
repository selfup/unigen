defmodule Mix.Tasks.Unigen.Single do
  @moduledoc """
    Runs task for single universe generation via an actor model
  """

  def run(_) do
    universe = Unigen.generate(1)
    atoms = MainActor.animate_atoms(universe)
    Agent.get(atoms, fn map -> map end)
  end
end
