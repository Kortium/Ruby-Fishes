# Класс аквариума, содержит в себе рыб, отображает себя и рыб.
# Не дает выплыть рыбам за пределы себя (предупреждает их о том что они пытаются это сделать)
# Ну и пока все
require 'fish'
require 'helper'

class Tank

  def initialize (size_x = 70, size_y = 20, fish_number = 17)
    @size = {:x => size_x, :y => size_y}
    @fish_number = fish_number
    @fishes = Array.new(fish_number)
    @alive_fishes = fish_number
    for i in 0..fish_number-1
      x = rand(8..size_x)-4
      y = rand(size_y)
      @fishes[i] = Fish.new(x,y)
    end
  end
  def restart (size_x = 70, size_y = 20, fish_number = 17)
    @size[:x] = size_x
    @size[:y] = size_y
    @fish_number = fish_number
    Curses.clear
    @fishes = Array.new(fish_number)
    @alive_fishes = fish_number
    for i in 0..fish_number-1
      x = rand(8..size_x)-4
      y = rand(size_y)
      @fishes[i] = Fish.new(x,y)
    end
  end
  def draw_tank
    i=0
    j=1
    draw_fishes
    put_at_coordinates(0, 0, '|')
    for j in 1..@size[:x]
      put_at_coordinates(j, 0, '~')
    end
    put_at_coordinates(@size[:x], 0, '|')
    for i in 1..@size[:y]-1
      put_at_coordinates(0, i, '|')
      put_at_coordinates(@size[:x], i, '|')
    end
    put_at_coordinates(0, @size[:y], '|')
    for j in 1..@size[:x]
      put_at_coordinates(j, @size[:y], '_')
    end
    put_at_coordinates(@size[:x], @size[:y], '|')
  end
  def get_size
    @size
  end
  def draw_fishes
    @fishes.each { |fish|
      coords = fish.get_coords
      put_at_coordinates(coords[:x], coords[:y], fish.get_fish_view)
    }
  end
  def clear_fishes
    @fishes.each { |fish|
      coords = fish.get_coords
      put_at_coordinates(coords[:x], coords[:y], fish.get_fish_clear)
    }
  end
  def alive_fishes?
    count_alive_fishes
    if @alive_fishes>0 then true
    else false
    end
  end
  def get_alive_fishes
    count_alive_fishes
  end
  def count_alive_fishes
    @alive_fishes = 0
    @fishes.each { |fish|
      if fish.is_alive? then @alive_fishes +=1 end
    }
    @alive_fishes
  end
  def update_fishes
    @fishes.each { |fish|
      fish.update_single_fish
      hit = check_boundaries(fish.get_coords, fish.get_model_length)
      if hit then
        fish.turn_around!
        fish.swim!
      end
    }
  end
  def check_boundaries(coord = {:x => 3, :y => 3}, length = 4)
    if coord[:x]-1<0 || coord[:x]+4>@size[:x]
      true
    elsif coord[:y]<1 || coord[:y]>=@size[:y]
      true
    else
      false
    end
  end
end
