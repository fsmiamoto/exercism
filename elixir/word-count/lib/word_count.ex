defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.replace(~r/[^[:lower:] \d-_]/u, "")
    |> String.replace("_", " ")
    |> String.split()
    |> Enum.reduce(%{}, fn word, map ->
      Map.update(map, word, 1, fn count ->
        count + 1
      end)
    end)
  end
end
