defmodule CliTest do
  use ExUnit.Case
  doctest Weather

  import Weather.CLI, only: [parse_args: 1]

  test ":help returned by option parsing with -h and --help options" do
    assert parse_args(["-h",     "anything"]) == :help
    assert parse_args(["-h",     ""])         == :help
    assert parse_args(["--help", "anything"]) == :help
    assert parse_args(["--help", ""])         == :help
  end

  test "no value returned if nothing given" do
    assert parse_args([]) == {}
  end
end

