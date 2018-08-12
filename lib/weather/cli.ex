defmodule Weather.CLI do
  import Record, only: [defrecord: 2, extract: 2]

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

  def process({}) do
    Weather.NWSData.fetch()
    |> decode_response
    |> convert_to_documents
    |> extract_data(["location", "observation_time_rfc822", "weather", "temperature_string", "relative_humidity", "wind_string", "pressure_string"])
  end

  def decode_response({:ok, body}), do: body
  def decode_response({:error, error}) do
    IO.puts "Error occured during fetching from National Weather Service.\n#{error}"
    System.halt(2)
  end

  def convert_to_documents(xml) do
    xml
    |> :binary.bin_to_list
    |> :xmerl_scan.string
  end

  def extract_data({doc, _}, headers) do
    Enum.map(headers, fn header ->
      [a] = :xmerl_xpath.string('//#{header}/text()', doc)
      xmlText(a, :value)
    end)
  end
end

