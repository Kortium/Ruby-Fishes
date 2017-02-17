# Класс реализующий методы которые я не смог логически никуда распределить

require 'curses'

def put_at_coordinates(x = 0, y = 0, string = "")
  Curses.setpos(y, x)
  Curses.addstr(string)
end
