defmodule RobotSimulator do
  @valid_directions [:north, :east, :south, :west]

  defguard is_valid_direction(dir) when dir in @valid_directions
  defguard is_valid_position(x, y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})

  def create(dir, {x, y} = pos)
      when is_valid_direction(dir) and is_valid_position(x, y) do
    %{:position => pos, :direction => dir}
  end

  def create(dir, _pos) when not is_valid_direction(dir) do
    {:error, "invalid direction"}
  end

  def create(_dir, _pos) do
    {:error, "invalid position"}
  end

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions),
    do: run_instructions(robot, instructions)

  defp run_instructions(%{direction: direction} = robot, "L" <> instructions) do
    %{robot | direction: turn(direction, "L")}
    |> run_instructions(instructions)
  end

  defp run_instructions(%{direction: direction} = robot, "R" <> instructions) do
    %{robot | direction: turn(direction, "R")}
    |> run_instructions(instructions)
  end

  defp run_instructions(%{position: position, direction: direction} = robot, "A" <> instructions) do
    %{robot | position: move(direction, position)}
    |> run_instructions(instructions)
  end

  defp run_instructions(robot, "") do
    robot
  end

  defp run_instructions(_robot, _instructions) do
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

  defp move(dir, {x, y}) do
    case dir do
      :west -> {x - 1, y}
      :east -> {x + 1, y}
      :north -> {x, y + 1}
      :south -> {x, y - 1}
    end
  end

  defp turn(direction, "L") do
    case direction do
      :west -> :south
      :north -> :west
      :east -> :north
      :south -> :east
    end
  end

  defp turn(direction, "R") do
    case direction do
      :west -> :north
      :north -> :east
      :east -> :south
      :south -> :west
    end
  end
end
