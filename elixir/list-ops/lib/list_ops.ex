defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    l |> count_iter(0)
  end

  defp count_iter([_ | tail], count) do
    tail |> count_iter(count + 1)
  end

  defp count_iter([], count) do
    count
  end

  @spec reverse(list) :: list
  def reverse(l) do
    l |> reverse_iter([])
  end

  defp reverse_iter([head | tail], acc) do
    tail |> reverse_iter([head | acc])
  end

  defp reverse_iter([], acc) do
    acc
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l |> map_iter([], f) |> reverse
  end

  defp map_iter([head | tail], acc, f) do
    tail |> map_iter([f.(head) | acc], f)
  end

  defp map_iter([], acc, _) do
    acc
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l |> filter_iter([], f) |> reverse
  end

  defp filter_iter([head | tail], acc, f) do
    should_keep = f.(head)

    if should_keep do
      tail |> filter_iter([head | acc], f)
    else
      tail |> filter_iter(acc, f)
    end
  end

  defp filter_iter([], acc, _) do
    acc
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce(l, acc, f) do
    l |> reduce_iter(acc, f)
  end

  defp reduce_iter([head | tail], acc, f) do
    tail |> reduce_iter(f.(head, acc), f)
  end

  defp reduce_iter([], acc, _) do
    acc
  end

  @spec append(list, list) :: list
  def append(a, b) do
    a |> reverse |> append_iter(b) |> reverse
  end

  defp append_iter(a, [head | tail]) do
    append_iter([head | a], tail)
  end

  defp append_iter(a, []) do
    a
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    reduce(ll, [], fn l, acc -> append(acc, l) end)
  end
end
