defmodule BathroomTest do
  use ExUnit.Case
  doctest Bathroom

  test "Bathroom.at" do
    assert Bathroom.at({0, 0}) == 1
    assert Bathroom.at({1, 0}) == 2
    assert Bathroom.at({2, 0}) == 3

    assert Bathroom.at({0, 1}) == 4
    assert Bathroom.at({1, 1}) == 5
    assert Bathroom.at({2, 1}) == 6

    assert Bathroom.at({0, 2}) == 7
    assert Bathroom.at({1, 2}) == 8
    assert Bathroom.at({2, 2}) == 9
  end

  test "load_patterns" do
    d1 = "LLLDDDUU"
    d2 = "DDUUULLRR"
    d3 = "LLDDURD"
    state = Bathroom.init
    found = Bathroom.load_patterns([d1, d2, d3], state)
    assert found.digits == "138"
  end

  test "load_pattern" do
    pattrn = "LLDDUU"
    state = Bathroom.init
    new_pos = Bathroom.load_pattern(pattrn, state.pos)
    assert new_pos == {0, 0}

    pattrn = "DDUUULLRR"
    state = Bathroom.init({0, 0})
    new_pos = Bathroom.load_pattern(pattrn, state.pos)
    assert new_pos == {2, 0}
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
    pos = Bathroom.init().pos

    new_pos = Bathroom.make_move(:left, pos)
    assert new_pos == {0, 1}

    new_pos = Bathroom.make_move(:right, pos)
    assert new_pos == {2, 1}

    new_pos = Bathroom.make_move(:up, pos)
    assert new_pos == {1, 0}

    new_pos = Bathroom.make_move(:down, pos)
    assert new_pos == {1, 2}

    new_pos = Bathroom.make_move(:down, {2, 2})
    assert new_pos == {2, 2}
  end
end
