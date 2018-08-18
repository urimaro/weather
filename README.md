# Weather

This project is for a practice of the Programming Elixir 1.2.

- OrganizingAProject - 6

When you execute the `./weather` command, you can get latest weather data of Denton Enterprise Airport.

```
location                      | observation_time_rfc822         | weather | temperature_string | relative_humidity | wind_string | pressure_string
------------------------------+---------------------------------+---------+--------------------+-------------------+-------------+----------------
Denton Enterprise Airport, TX | Sat, 18 Aug 2018 01:53:00 -0500 | Fair    | 78.0 F (25.6 C)    | 79                | Calm        | 1014.5 mb      
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `weather` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:weather, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/weather](https://hexdocs.pm/weather).

## Usage

Execute the following command.

```
$ cd path/to/this_project
$ ./weather
```

