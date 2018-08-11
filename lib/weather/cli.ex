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
    |> decode_response
    |> convert_to_documents
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
end

