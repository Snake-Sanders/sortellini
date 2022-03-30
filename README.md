# Sortellini

**Sortellini** sorts the content of an `.ini` file. The main purpose of this module is to ease the diff between two ini files where the sections are mixed up and the key values have no orther watsoever, this is especifically a pain with big ini files.

```elixir
file_path = "path/to/my.ini"
Sortellini.sort_ini(file_path)
# this will hopefully create a file "path/to/my_sorted.ini"
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

