defmodule BankAccount do
  @moduledoc """
  A bank account that supports access from multiple processes.
  """

  @typedoc """
  An account handle.
  """
  @opaque account :: pid

  @err_closed {:error, :account_closed}

  @doc """
  Open the bank. Makes the account available.
  """
  @spec open_bank() :: account
  def open_bank() do
    {:ok, pid} = GenServer.start_link(__MODULE__, %{balance: 0, closed: false})
    pid
  end

  @doc """
  Close the bank. Makes the account unavailable.
  """
  @spec close_bank(account) :: none
  def close_bank(account), do: GenServer.cast(account, :close)

  @doc """
  Get the account's balance.
  """
  @spec balance(account) :: integer
  def balance(account), do: GenServer.call(account, :balance)

  @doc """
  Update the account's balance by adding the given amount which may be negative.
  """
  @spec update(account, integer) :: any
  def update(account, amount), do: GenServer.call(account, {:update, amount})

  def handle_call(:balance, _, %{closed: true} = acc), do: {:reply, @err_closed, acc}
  def handle_call(:balance, _, acc), do: {:reply, acc.balance, acc}

  def handle_call({:update, _}, _, %{closed: true} = acc), do: {:reply, @err_closed, acc}

  def handle_call({:update, amount}, _, acc),
    do: {:reply, :ok, %{acc | balance: acc.balance + amount}}

  def handle_cast(:close, a), do: {:noreply, %{a | closed: true}}

  def init(account), do: {:ok, account}
end
