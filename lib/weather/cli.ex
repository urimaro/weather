defmodule Weather.CLI do
  import Record, only: [defrecord: 2, extract: 2]
  import Weather.XML, only: [convert_to_map: 2]

  defrecord :xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

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

  @headers ["location", "observation_time_rfc822", "weather", "temperature_string", "relative_humidity", "wind_string", "pressure_string"]

  def process({}) do
    Weather.NWSData.fetch()
    |> decode_response
    |> convert_to_map(@headers)
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error occured during fetching from National Weather Service.\n#{error}"
    System.halt(2)
  end
end

