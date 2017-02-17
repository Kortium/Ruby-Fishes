# Класс аквариума, содержит в себе рыб, отображает себя и рыб.
# Не дает выплыть рыбам за пределы себя (предупреждает их о том что они пытаются это сделать)
# Ну и пока все
require './fish.rb'
require './helper.rb'

class Tank

  def initialize (size_x = 40, size_y = 10, fish_number = 7)
    @size = {:x => size_x, :y => size_y}
    @fish_number = fish_number
    @fishes = Array.new(fish_number)
    for i in 0..fish_number-1
      x = rand(8..size_x)-4
      y = rand(size_y)
      @fishes[i] = Fish.new(x,y)
    end
    puts('Jobs done')
    puts(@fishes.to_s)
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
    Curses.refresh
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
  def update_fishes
    @fishes.each { |fish|
      current_move = rand(6)
      if current_move == 0
        fish.rotate!
      else
        fish.swim!
      end
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
  def runtime
    system "clear"
    while true
      clear_fishes
      update_fishes
      draw_tank
      sleep 0.2
    end
  end

end

tank = Tank.new
tank.runtime
