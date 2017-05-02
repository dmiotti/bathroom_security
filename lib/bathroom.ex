defmodule Bathroom do

  @keypad { {1, 2, 3}, {4, 5, 6}, {7, 8, 9} }

  def at(pos) do
    case pos do
      {x, _} when x < 0 or x > 2 -> :none
      {_, y} when y < 0 or y > 2 -> :none
      {x, y} -> elem(elem(@keypad, x), y)
    end
  end
end
