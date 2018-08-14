defmodule Weather.TableFormatter do
  def print_table_for_data(data, headers) do
    column_list = create_column_list(data, headers)
    column_widths = width_of(column_list)
  end

  def create_column_list(data, headers) do
    Enum.zip(data, headers)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
  end

  def width_of(column_list) do
    for column <- column_list, do: column |> Enum.map(&String.length/1) |> Enum.max
  end
end

