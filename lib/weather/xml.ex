defmodule Weather.XML do
  import Record, only: [defrecord: 2, extract: 2]

  defrecord :xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def convert_to_map(xml, headers) do
    xml
    |> convert_to_documents
    |> extract_data(headers)
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

