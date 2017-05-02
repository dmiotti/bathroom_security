defmodule BathroomTest do
  use ExUnit.Case
  doctest Bathroom

  test "Bathroom.at" do
    assert Bathroom.at({0, 0}) == 1
    assert Bathroom.at({0, 1}) == 2
    assert Bathroom.at({0, 2}) == 3
    assert Bathroom.at({1, 0}) == 4
    assert Bathroom.at({1, 1}) == 5
    assert Bathroom.at({1, 2}) == 6
    assert Bathroom.at({2, 0}) == 7
    assert Bathroom.at({2, 1}) == 8
    assert Bathroom.at({2, 2}) == 9
  end

  test ":none when out of bound" do
    assert Bathroom.at({-1, 0}) == :none
    assert Bathroom.at({5, 1}) == :none
  end

  test "get_x / get_y" do
    pos = {1, 2}
    assert Bathroom.get_x(pos) == 1
    assert Bathroom.get_y(pos) == 2
  end

  test "default State pos" do
    state = Bathroom.init()
    assert Bathroom.get_x(state.pos) == 1
    assert Bathroom.get_y(state.pos) == 1
  end

  test "convert_move" do
    assert Bathroom.convert_move("L") == :left
    assert Bathroom.convert_move("R") == :right
    assert Bathroom.convert_move("U") == :up
    assert Bathroom.convert_move("D") == :down
    assert Bathroom.convert_move("X") == :none
  end

  test "move_matrix" do
    assert Bathroom.move_matrix(:left) == {-1, 0}
    assert Bathroom.move_matrix(:right) == {1, 0}
    assert Bathroom.move_matrix(:up) == {0, -1}
    assert Bathroom.move_matrix(:down) == {0, 1}
  end

  test "make_move" do
    state = Bathroom.init()

    new_state = Bathroom.make_move(:left, state)
    assert new_state.pos == {0, 1}

    new_state = Bathroom.make_move(:right, state)
    assert new_state.pos == {2, 1}

    new_state = Bathroom.make_move(:up, state)
    assert new_state.pos == {1, 0}

    new_state = Bathroom.make_move(:down, state)
    assert new_state.pos == {1, 2}

    state = Bathroom.make_move(:down, Bathroom.init({2, 2}))
    assert state.pos == {2, 2}
  end
end
