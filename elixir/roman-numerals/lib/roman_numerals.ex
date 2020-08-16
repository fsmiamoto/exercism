defmodule RomanNumerals do
  @arabic_to_roman [
    {1000, "M"},
    {900, "CM"},
    {500, "D"},
    {400, "CD"},
    {100, "C"},
    {90, "XC"},
    {50, "L"},
    {40, "XL"},
    {10, "X"},
    {9, "IX"},
    {5, "V"},
    {4, "IV"},
    {1, "I"}
  ]

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    add_roman_numerals("", number, @arabic_to_roman)
  end

  defp add_roman_numerals(result, _, []) do
    result
  end

  defp add_roman_numerals(result, number, conversion_list) do
    [{arabic, roman} | other_numerals] = conversion_list

    should_repeat_count = div(number, arabic)

    add_roman_numerals(
      result <> String.duplicate(roman, should_repeat_count),
      rem(number, arabic),
      other_numerals
    )
  end
end
