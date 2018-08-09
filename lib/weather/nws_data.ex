defmodule Weather.NWSData do
  @data_url "http://w1.weather.gov/xml/current_obs/KDTO.xml"

  def fetch() do
    @data_url
    |> HTTPoison.get
    |> handle_response
  end

  def handle_response({:ok, %{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:error, %{status_code: _, body: body}}) do
    {:error, body}
  end
end

