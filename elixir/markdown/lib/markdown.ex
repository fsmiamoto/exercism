defmodule Markdown do
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
    |> Enum.map(&parse_line(&1))
    |> Enum.join()
    |> wrap_list_items_with_ul_tag
  end

  defp parse_line(line = "#" <> _) do
    line |> parse_header |> enclose_with_header_tag
  end

  defp parse_line(line = "*" <> _) do
    line |> parse_list_item |> enclose_with_li_tag
  end

  defp parse_line(line) do
    line |> String.split() |> enclose_with_paragraph_tag
  end

  defp parse_header(hwt) do
    [h | t] = String.split(hwt)
    {to_string(String.length(h)), Enum.join(t, " ")}
  end

  defp parse_list_item(l) do
    l
    |> String.trim_leading("* ")
    |> String.split()
  end

  defp enclose_with_li_tag(t) do
    "<li>#{join_words_with_tags(t)}</li>"
  end

  defp enclose_with_header_tag({h_level, h_text}) do
    "<h#{h_level}>#{h_text}</h#{h_level}>"
  end

  defp enclose_with_paragraph_tag(t) do
    "<p>#{join_words_with_tags(t)}</p>"
  end

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&replace_md_with_tag(&1))
    |> Enum.join(" ")
  end

  defp replace_md_with_tag(word) do
    word
    |> replace_prefix_md
    |> replace_suffix_md
  end

  defp replace_prefix_md(word) do
    word
    |> String.replace_leading("__", "<strong>")
    |> String.replace_leading("_", "<em>")
  end

  defp replace_suffix_md(word) do
    word
    |> String.replace_trailing("__", "</strong>")
    |> String.replace_trailing("_", "</em>")
  end

  defp wrap_list_items_with_ul_tag(l) do
    l
    |> String.replace("<li>", "<ul><li>", global: false)
    |> String.replace_suffix("</li>", "</li></ul>")
  end
end
