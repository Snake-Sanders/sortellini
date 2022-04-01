defmodule Sortellini do
  require ConfigParser

  @moduledoc """
  Documentation for `Sortellini`.

  Alphabetically sorts the sections and subsections of an `.ini` file.
  """

  @doc """
  This function uses `sort_content` to create a copy file but with the sorted content.
  The copy file is written in the same directory, the file name will be `<file_name>_sorted.<ext>`.
  """
  def sort_out(file_path) do
    if not File.exists?(file_path) do
      IO.puts("The given path is not valid: " <> file_path)
    else
      out_file = get_output_path(file_path)

      file_path
      |> sort_content()
      |> file_write(out_file)

      IO.puts("file stored in: #{out_file}")
    end
  end

  @doc """
  Reads the content of a given file, `file_path`, alphabetically sorts the sections
  and key-value pairs withing the sections, and returns the data as a Map.
  The comment lines are ignored, these are, those starting with ; or #.
  """
  def sort_content(file_path) do
    file_path
    |> parse()
    |> tokenizer()
    |> Enum.map_join("\n", & &1)
  end

  # Reads the ini file and returns a Map
  defp parse(file) do
    {:ok, content} = ConfigParser.parse_file(file)
    content
  end

  # Receives a section name `sect` and the content of the ini file as `map`
  # retrieves the section and its pairs of key-value and serialize them as
  # `key = value`
  defp serialize_section(sect, map) do
    map
    |> Map.fetch!(sect)
    |> Enum.map(fn {key, value} ->
      "#{key} = #{value}"
    end)
  end

  # Serializes sections and its pair key-values
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

  # helper to swap the argument order so it can be pipped.
  defp file_write(data, file) do
    File.write!(file, data)
  end

  # From the input path to file, creates an output
  # path to file but with the file name suffixed with
  # path/to/<file-name>_sorted.<extension>
  defp get_output_path(file_path) do
    ext = Path.extname(file_path)
    String.replace_suffix(file_path, ext, "_sorted" <> ext)
  end
end
