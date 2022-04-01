defmodule Sortellini do
  require ConfigParser

  @moduledoc """
  Documentation for `Sortellini`.
  """

  def sort_ini(file_path) do
    out_file = get_output_path(file_path)

    file_path
    |> sort!()
    |> store_copy(out_file)

    IO.puts("file stored in: #{out_file}")
  end

  # reads a ini file and returns the same file but with the sections sorted
  def sort!(file) do
    file
    |> parse()
    |> tokenizer()
    |> Enum.map_join("\n", & &1)
  end

  # reads the ini file and returns a Map
  defp parse(file) do
    {:ok, content} = ConfigParser.parse_file(file)
    content
  end

  # receives a section name `sect` and the content of the ini file as `map`
  # retrieves the section and its pairs of key-value and serialize them as
  # `key = value`
  defp serialize_section(sect, map) do
    map
    |> Map.fetch!(sect)
    |> Enum.map(fn {key, value} ->
      "#{key} = #{value}"
    end)
  end

  # serializes sections and its pair key-values
  # and returns a string lines representing the section
  #
  # [section]
  # key1 = value 1
  # key2 = value 2
  defp tokenizer(ini_map) when is_map(ini_map) do
    Map.keys(ini_map)
    |> Enum.sort()
    |> Enum.map(fn sec ->
      pairs = serialize_section(sec, ini_map)

      str =
        (["[#{sec}]"] ++ pairs)
        |> Enum.map_join("\n", & &1)

      str <> "\n"
    end)
  end

  defp store_copy(data, file) do
    File.write!(file, data)
  end

  # from the input path to file, creates an output
  # path to file but with the file name suffixed with
  # path/to/<file-name>_sorted.<extension>
  defp get_output_path(file_path) do
    ext = Path.extname(file_path)
    String.replace_suffix(file_path, ext, "_sorted" <> ext)
  end
end
