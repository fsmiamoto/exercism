defmodule Markdown do
  """
  My changes involved the following points: 
  - Use the |> operator more, for being idiomatic and easier to read
  - Avoid Regular Expressions, they're powerful but definitely harder to read and reason about
  - Standardize functions for having a consistent set of steps for any line that will be parsed
  - Improve naming

  I think it could definitely still improve but would love to hear some feedback!
  """

  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """
  @spec parse(String.t()) :: String.t()
  def parse(md) do
    md
    |> String.split("\n")
    |> Enum.map_join(&parse_line(&1))
    |> wrap_list_items_with_ul_tag
  end

  defp parse_line(line = "#" <> _) do
    line |> parse_header |> enclose_with_header_tag
  end

  defp parse_line(line = "*" <> _) do
    line |> parse_list_item |> enclose_with_li_tag
  end

  defp parse_line(line) do
    line |> parse_paragraph |> enclose_with_paragraph_tag
  end

  defp parse_header(h) do
    [hashes | rest] = String.split(h)
    {String.length(hashes), Enum.join(rest, " ")}
  end

  defp parse_list_item(li) do
    li |> String.trim_leading("* ") |> String.split()
  end

  defp parse_paragraph(p) do
    p |> String.split()
  end

  defp enclose_with_li_tag(words) do
    "<li>#{join_words_with_tags(words)}</li>"
  end

  defp enclose_with_header_tag({h_level, h_text}) do
    "<h#{h_level}>#{h_text}</h#{h_level}>"
  end

  defp enclose_with_paragraph_tag(words) do
    "<p>#{join_words_with_tags(words)}</p>"
  end

  defp join_words_with_tags(words) do
    words |> Enum.map_join(" ", &replace_md_with_tag(&1))
  end

  defp replace_md_with_tag(word) do
    word
    |> String.replace_leading("__", "<strong>")
    |> String.replace_leading("_", "<em>")
    |> String.replace_trailing("__", "</strong>")
    |> String.replace_trailing("_", "</em>")
  end

  defp wrap_list_items_with_ul_tag(li) do
    li
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
