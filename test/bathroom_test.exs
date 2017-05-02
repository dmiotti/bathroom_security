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
end
