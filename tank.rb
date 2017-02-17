# Класс аквариума, содержит в себе рыб, отображает себя и рыб.
# Не дает выплыть рыбам за пределы себя (предупреждает их о том что они пытаются это сделать)
# Ну и пока все
require './fish.rb'
require './helper.rb'

class Tank

  def initialize (size_x = 20, size_y = 10, fish_number = 4)
    @size = {:x => size_x, :y => size_y}
    @fish_number = fish_number
    @fishes = Array.new(fish_number)
    for i in 0..fish_number-1
      x = rand(size_x)
      y = rand(size_y)
      @fishes[i] = Fish.new(x,y)
    end
    puts('Jobs done')
    puts(@fishes.to_s)
  end
  def draw_tank
    system "clear"
    draw_fishes
    for i in 0..@size[:y]-1
      put_at_coordinates(0, i, '|')
      put_at_coordinates(@size[:x], i, '|')
    end
    put_at_coordinates(0, @size[:y], '|')
    for j in 1..@size[:x]
      put_at_coordinates(j, @size[:y], '_')
    end
    put_at_coordinates(@size[:x], @size[:y], '|')
    Curses.getch
  end
  def draw_fishes
    @fishes.each { |fish|
      coords = fish.get_coords
      put_at_coordinates(coords[:x], coords[:y], fish.get_fish_view)
    }
  end

end

tank = Tank.new
tank.draw_tank
