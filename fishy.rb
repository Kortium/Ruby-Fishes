require './tank'
require './store'
class Engine
  def initialize
    @state = Store.new
  end
  def runtime(tank)
    system "clear"
    Curses.noecho
    $state = "working"
    t = Thread.new do
      while true
        case $state
        when "working"
          Curses.clear
          tank_size = tank.get_size
          tank.clear_fishes
          tank.update_fishes
          tank.draw_tank
          fish_number_string = tank.get_alive_fishes.to_s
          if fish_number_string.length<2 then fish_number_string<<' ' end
          put_at_coordinates(tank_size[:x]+4, 1, fish_number_string)
          sleep 0.2
        when "restart"
          tank.restart
          $state = "working"
        when "pause"
          sleep 0.2
        when "continue"
          $state = "working"
        end
        put_at_coordinates(0, tank_size[:y]+2, $state)
        Curses.refresh
      end
    end
    char = Curses.getch
    until char == "q"
      char = Curses.getch
      case char
      when "r"
        $state = "restart"
      when "p"
        $state = "pause"
      when "c"
        $state = "continue"
      end
    end
    t.kill
  end
end

engine = Engine.new
tank = Tank.new(40,10,24)
engine.runtime(tank)
