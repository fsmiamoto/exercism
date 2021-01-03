defmodule SecretHandshake do
  use Bitwise

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) when (code &&& 16) == 16 do
    code
    |> do_([], [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ])
    |> Enum.reverse()
  end

  def commands(code) do
    code
    |> do_([], [
      {1, "wink"},
      {2, "double blink"},
      {4, "close your eyes"},
      {8, "jump"}
    ])
  end

  defp do_(_, current, []) do
    current
  end

  defp do_(code, current, [{digit, phrase} | tail]) when (code &&& digit) == digit,
    do: do_(code, current ++ [phrase], tail)

  defp do_(code, current, [_ | tail]), do: do_(code, current, tail)
end
