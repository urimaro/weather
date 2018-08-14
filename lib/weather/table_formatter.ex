defmodule Weather.TableFormatter do
  def print_table_for_data(data, headers) do
    column_list = create_column_list(data, headers)
  end

  def create_column_list(data, headers) do
    Enum.zip(data, headers)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
  end
end

