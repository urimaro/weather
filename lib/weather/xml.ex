defmodule Weather.XML do
  import Record, only: [defrecord: 2, extract: 2]

  defrecord :xmlText, extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def convert_to_data_list(xml, headers) do
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
      [doc] = :xmerl_xpath.string('//#{header}/text()', doc)
      doc
      |> xmlText(:value)
      |> to_string
    end)
  end
end

