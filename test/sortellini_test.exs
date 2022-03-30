defmodule SortelliniTest do
  use ExUnit.Case
  doctest Sortellini

  setup do
    {:ok, dir_p: "./test/samples/"}
  end

  test "sort simple ini file", %{dir_p: dir_path} do
    expected = """
    [sectionA]
    key1 = a

    [sectionB]
    key2 = b
    """

    file = dir_path <> "plain.ini"
    content = Sortellini.sort!(file)

    assert content == expected
  end

  test "sort complex ini file", %{dir_p: dir_path} do
    expected = """
    [sectionA]
    key1 = a
    key2 = b

    [sectionB]
    key1 = a
    key2 = b
    key3 = c
    key4 = d

    [sectionC]
    key1 = a

    [sectionD]
    key_a = c:/temp/path/file.ini
    key_b = <driver>
    """

    file = dir_path <> "complex.ini"
    content = Sortellini.sort!(file)

    assert content == expected
  end
end
