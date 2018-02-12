defmodule Mix.Tasks.Unigen.Start do
  @moduledoc """
    Runs Tasks For Cluster Deployment
  """

  defp calc_limit(args) do
    limit_arg = Enum.fetch!(args, 1)
    elem(Integer.parse(limit_arg), 0)
  end

  def run(_) do
    args = System.argv()
    cond do
      (length(args) == 2) -> Unigen.deploy_clusters(calc_limit(args), false)
      (length(args) > 2) -> Unigen.deploy_clusters(calc_limit(args), true)
      true -> IO.puts "Please give at least one argument"
    end
  end
end
