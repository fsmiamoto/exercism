defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    l |> reduce(0, fn _, acc -> acc + 1 end)
  end

  @spec reverse(list) :: list
  def reverse(l) do
    l |> reduce([], fn item, acc -> [item | acc] end)
  end

  @spec map(list, (any -> any)) :: list
  def map(l, f) do
    l |> reduce([], fn item, acc -> [f.(item) | acc] end) |> reverse
  end

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter(l, f) do
    l |> reduce([], &filter_item(&1, &2, f)) |> reverse
  end

  defp filter_item(item, acc, f) do
    if f.(item) do
      [item | acc]
    else
      acc
    end
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
    a |> reverse |> reduce(b, &[&1 | &2])
  end

  @spec concat([[any]]) :: [any]
  def concat(ll) do
    f = &[&1 | &2]
    ll |> reduce([], &reduce(&1, &2, f)) |> reverse
  end
end
