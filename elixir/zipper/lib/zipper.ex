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
  def up({tree, :top}) do
    nil
  end

  def up({_, {_, tree, trail}}) do
    {tree, trail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value) do
  end

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left) do
  end

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right) do
  end
end
