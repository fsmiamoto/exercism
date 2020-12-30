defmodule Zipper do
  @type trail ::
          :top
          | {:left, BT.t(), trail}
          | {:right, BT.t(), trail}

  @moduledoc """
  A zipper for a binary tree

  `tree` is the value of a node.
  """
  @type t :: {BT.t(), trail}

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(tree) do
    {tree, :top}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree({tree, :top}) do
    tree
  end

  def to_tree(zipper) do
    zipper |> up() |> to_tree()
  end

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value({tree, _}) do
    tree.value
  end

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left({%{left: left}, _}) when is_nil(left) do
    nil
  end

  def left({tree, trail}) do
    {tree.left, {:left, tree, trail}}
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right({%{right: right}, _}) when is_nil(right) do
    nil
  end

  def right({tree, trail}) do
    {tree.right, {:right, tree, trail}}
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up({_, :top}) do
    nil
  end

  def up({_, {_, tree, trail}}) do
    {tree, trail}
  end

  @doc """
  Set the value of the focus node.j
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value({tree, trail}, new_value) do
    tree = %{tree | value: new_value}
    {tree, update_parents(trail, tree)}
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left({tree, :top}, left) do
    {%{tree | left: left}, :top}
  end

  def set_left({tree, trail}, left) do
    tree = %{tree | left: left}
    {tree, update_parents(trail, tree)}
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right({tree, :top}, right) do
    {%{tree | right: right}, :top}
  end

  def set_right({tree, trail}, right) do
    tree = %{tree | right: right}
    {tree, update_parents(trail, tree)}
  end

  defp update_parents({direction, tree, :top}, new) do
    updated = tree |> Map.put(direction, new)
    {direction, updated, :top}
  end

  defp update_parents({direction, tree, trail}, new) do
    updated_tree = tree |> Map.put(direction, new)
    updated_parent_trail = update_parents(trail, updated_tree)
    {direction, updated_tree, updated_parent_trail}
  end
end
