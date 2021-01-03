defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(numbers, key) do
    list = numbers |> Tuple.to_list()
    search_helper(list, key, 0, length(list) - 1)
  end

  defp search_helper(list, key, first, last) when first > last do
    index = div(first + last, 2)

    if Enum.at(list, index) != key do
      :not_found
    else
      {:ok, index}
    end
  end

  defp search_helper(list, key, first, last) do
    index = div(first + last, 2)
    middle = Enum.at(list, index)

    cond do
      key == middle -> {:ok, index}
      key > middle -> search_helper(list, key, index + 1, last)
      key < middle -> search_helper(list, key, first, index - 1)
    end
  end
end
