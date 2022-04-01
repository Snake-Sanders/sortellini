# Sortellini

**Sortellini** sorts in alphabetically order the content of a given `.ini` file. The main purpose of this module is to ease the diff between two `.ini` files where the sections are mixed up and the key values have no order whatsoever, which it is a pain when dealing with big `.ini` files.

The script uses the module `configparser_ex` and will ignore the comments within the file.

```elixir
iex> file_path = "path/to/my.ini"
iex> Sortellini.sort_ini(file_path)
file stored in: path/to/my_sorted.ini
:ok
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `sortellini` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:sortellini, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/sortellini](https://hexdocs.pm/sortellini).

