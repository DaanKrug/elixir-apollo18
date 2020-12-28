defmodule Apollo18.MixProject do
  use Mix.Project
  
  @project_url "https://github.com/DaanKrug/elixir-apollo18"

  def project do
    [
      app: :apollo18,
      version: "0.1.1",
      elixir: "~> 1.11",
      source_url: @project_url,
      homepage_url: @project_url,
      name: "Apollo18",
      description: "Provides mechanism to make your things be like Apollo 18: Officially don't exists, only the owner know that it (if ?) exists. The truth is out there (Maybe ...).",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      package: package(),
      docs: [main: "readme", extras: ["README.md"]],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:earmark, "~> 1.4.13", only: :dev, runtime: false},
      {:ex_doc, "~> 0.22", only: :dev, runtime: false},
      {:krug, "~> 0.4.2"}
    ]
  end
  
  defp aliases do
    [c: "compile", d: "docs"]
  end
  
  defp package do
    [
      maintainers: ["Daniel Augusto Krug @daankrug <daniel-krug@hotmail.com>"],
      licenses: ["MIT"],
      links: %{"GitHub" => @project_url}
    ]
  end
  
end
