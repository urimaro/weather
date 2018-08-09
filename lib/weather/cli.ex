defmodule Weather.CLI do
  @moduledoc """
  """
  def run(argv) do
    argv
    |> parse_args()
    |> process
  end

  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [help: :boolean],
                                     aliases:  [h:    :help   ])

    case parse do
      {[help: true], _, _} ->
        :help
      {_, [], _} ->
        {}
      _ ->
        :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: weather
    """
    System.halt(0)
  end

  def process({}) do
    Weather.NWSData.fetch()
  end
end

