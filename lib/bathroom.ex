defmodule Bathroom do

  @keypad {
    {:none, :none, "1", :none, :none},
    {:none, "2", "3", "4", :none},
    {"5", "6", "7", "8", "9"},
    {:none, "A", "B", "C", :none},
    {:none, :none, "D", :none, :none}
  }

  defmodule State do
    defstruct pos: {1, 1}, digits: nil
  end

  def init(pos \\ {1, 1}), do: %State{pos: pos}

  def load_patterns(patterns, state) do
    patterns |> Enum.reduce(state, fn (pattern, state) ->
      new_pos = load_pattern(pattern, state.pos)
      digit = case at(new_pos) do
        :none -> nil
        val -> val
      end
      %{state | pos: new_pos, digits: "#{state.digits}#{digit}"}
    end)
  end

  def load_pattern(pattern, pos) do
    pattern |> String.graphemes |> Enum.reduce(pos, fn (char, pos) ->
      case convert_move(char) do
        :none -> pos
        move -> make_move(move, pos)
      end
    end)
  end

  def make_move(move, pos) do
    m = move_matrix(move)
    new_pos = {
      get_x(pos) + get_x(m),
      get_y(pos) + get_y(m)
    }
    case at(new_pos) do
      :none -> pos
      _ -> new_pos
    end
  end

  def move_matrix(move) do
    case move do
      :left   -> {-1,  0}
      :right  -> { 1,  0}
      :up     -> { 0, -1}
      :down   -> { 0,  1}
    end
  end

  def get_x(pos), do: elem(pos, 0)
  def get_y(pos), do: elem(pos, 1)

  def convert_move(str) do
    case str do
      "L" -> :left
      "R" -> :right
      "U" -> :up
      "D" -> :down
      _   -> :none
    end
  end

  def at(pos) do
    case pos do
      {x, _} when x < 0 or x > 4 -> :none
      {_, y} when y < 0 or y > 4 -> :none
      {x, y} -> elem(elem(@keypad, y), x)
    end
  end
end
