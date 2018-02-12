defmodule MainActor do
  @moduledoc """
    Makes a continuous process for each atom and maintains a single state
  """

  def add_atom_agent(universe, agent) do
    universe
    |> Enum.each(fn atom ->
      {:ok, atom_agent} = Agent.start_link fn -> %{} end
      Agent.update(agent, fn atoms -> Map.put(atoms, atom_agent, atom) end)
    end)
    agent
  end

  def animate_atoms(universe) do
    {:ok, agent} = Agent.start_link fn -> %{} end
    add_atom_agent(universe, agent)
  end
end
