#!/usr/bin/env ruby

require_relative "../tank"
require "test/unit"

class TestTank < Test::Unit::TestCase

  def test_initialize
    assert_instance_of(Tank, Tank.new)
  end
  def test_get_methods
    tank = Tank.new(30,10,4)
    assert_equal({:x => 30, :y => 10} ,tank.get_size)
    assert_equal(4,tank.get_alive_fishes)
    tank = Tank.new(40,15,7)
    assert_equal({:x => 40, :y => 15} ,tank.get_size)
    assert_equal(7,tank.get_alive_fishes)
    tank = Tank.new(20,10,23)
    assert_equal({:x => 20, :y => 10} ,tank.get_size)
    assert_equal(23,tank.get_alive_fishes)
  end
  def test_logic
    tank = Tank.new(30,10,4)
    assert_equal(true ,tank.alive_fishes?)
    assert_equal(false ,tank.check_is_out_of_boundaries({:x => 15, :y => 5}))
    assert_equal(true ,tank.check_is_out_of_boundaries({:x => 14, :y => 11}))
    assert_equal(true ,tank.check_is_out_of_boundaries({:x => 31, :y => 5}))
    assert_equal(true ,tank.check_is_out_of_boundaries({:x => 29, :y => 9}))
    assert_equal(true ,tank.check_is_out_of_boundaries({:x => 16, :y => 10}))
  end
  def test_exeptions
    assert_raise_message("This tank is to big") {tank = Tank.new(100,20)}
    assert_raise_message("This tank is to small") {tank = Tank.new(30,1)}
    assert_nothing_raised(RuntimeError) {tank = Tank.new(30,10)}
  end
end
