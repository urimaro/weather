defmodule Weather.TableFormatter do
  def print_table_for_data(data, headers) do
    column_list = create_column_list(data, headers)
    column_widths = width_of(column_list)
    format = format_for(column_widths)
    puts_one_line_in_columns(headers, format)
    IO.puts(separator(column_widths))
    puts_one_line_in_columns(data, format)
  end

  def create_column_list(data, headers) do
    Enum.zip(data, headers)
    |> Enum.map(fn x -> Tuple.to_list(x) end)
  end

  def width_of(column_list) do
    for column <- column_list, do: column |> Enum.map(&String.length/1) |> Enum.max
  end

  def format_for(column_widths) do
    Enum.map_join(column_widths, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  def puts_one_line_in_columns(fields, format) do
    :io.format(format, fields)
  end

  def separator(column_widths) do
    Enum.map_join(column_widths, "-+-", fn width -> List.duplicate("-", width) end)
  end
end

