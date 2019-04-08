defmodule Unigen.Mixfile do
  use Mix.Project

  def project do
    [
      app: :unigen,
      version: "0.1.0",
      elixir: "~> 1.8",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  defp deps do
    [
      {:credo, "~> 1.0.0", only: [:dev, :test], runtime: false}
    ]
  end
end
