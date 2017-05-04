defmodule Bathroom do

  @keypad { {1, 2, 3}, {4, 5, 6}, {7, 8, 9} }

  defmodule State do
    defstruct pos: {1, 1}
  end

  def init(pos \\ {1, 1}), do: %State{pos: pos}

  def make_move(move, state) do
    m = move_matrix(move)
    new_pos = {
      get_x(state.pos) + get_x(m), 
      get_y(state.pos) + get_y(m)
    }
    next = at(new_pos)
    case next do
      :none -> state
      _ -> %{state | pos: new_pos}
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
      {x, _} when x < 0 or x > 2 -> :none
      {_, y} when y < 0 or y > 2 -> :none
      {x, y} -> elem(elem(@keypad, x), y)
    end
  end
end
