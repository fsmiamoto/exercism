defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(direction, {x, y}) when is_integer(x) and is_integer(y) do
    if valid_direction?(direction) do
      %{:position => {x, y}, :direction => direction}
    else
      {:error, "invalid direction"}
    end
  end

  def create(_, _) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) do
    instructions
    |> String.to_charlist()
    |> Enum.chunk_every(1)
    |> Enum.reduce(robot, &reducer(&1, &2))
  end

  defp reducer(_dir, {:error, _}) do
    {:error, "invalid instruction"}
  end

  defp reducer('L', robot) do
    run_instruction(robot, 'L')
  end

  defp reducer('R', robot) do
    run_instruction(robot, 'R')
  end

  defp reducer('A', robot) do
    run_instruction(robot, 'A')
  end

  defp reducer(_dir, _robot) do
    {:error, "invalid instruction"}
  end

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(robot) do
    robot.direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(robot) do
    robot.position
  end

  defp run_instruction(robot, instruction) do
    case instruction do
      'L' -> create(change_direction(robot.direction, instruction), robot.position)
      'R' -> create(change_direction(robot.direction, instruction), robot.position)
      'A' -> create(robot.direction, move(robot.direction, robot.position))
    end
  end

  defp move(dir, {x, y}) do
    case dir do
      :west -> {x - 1, y}
      :east -> {x + 1, y}
      :north -> {x, y + 1}
      :south -> {x, y - 1}
    end
  end

  defp change_direction(dir, 'L') do
    case dir do
      :west -> :south
      :north -> :west
      :east -> :north
      :south -> :east
    end
  end

  defp change_direction(dir, 'R') do
    case dir do
      :west -> :north
      :north -> :east
      :east -> :south
      :south -> :west
    end
  end

  defp valid_direction?(direction) do
    case direction do
      :north -> true
      :south -> true
      :west -> true
      :east -> true
      _ -> false
    end
  end
end
