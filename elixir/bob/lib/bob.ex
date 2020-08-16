defmodule Bob do
  def hey(input) do
    cond do
      is_empty(input) -> "Fine. Be that way!"
      is_question(input) && is_uppercase(input) -> "Calm down, I know what I'm doing!"
      is_question(input) -> "Sure."
      is_uppercase(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end

  defp is_uppercase(str) do
    String.match?(str, ~r/[[:alpha:]]/) && String.upcase(str) == str
  end

  defp is_question(str) do
    str
    |> String.trim()
    |> String.ends_with?("?")
  end

  defp is_empty(str) do
    String.trim(str) == ""
  end
end
