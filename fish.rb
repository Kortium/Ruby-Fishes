# ><*> Класс Рыба, рыба умеет плавать, ее можно покормить, она может сдохнуть <*><

class Fish
  # Счетчик рыб
  @@fish_count=0
  @@directions=[:up, :down, :right, :left]
  # Модели рыбок
  @@fish_models={:up => "><*>", :right => "><*>", :left => "<*><", :down => "<*><"}
  @@dead_fish_models={:up => "><x>", :right => "><x>", :left => "<x><", :down => "<x><"}
  # Конструктор рыбы (можно передать имя)
  def initialize (x = 0, y = 0, orientation = :up, clear=false)
    # Параметры рыбы
    @coordinates = {:x => x, :y => y}
    @speed = 1
    @orientation = orientation
    @state = :alive
    #Обновляем счетчик рыб
    if clear then @@fish_count=0
      @@fish_count += 1
    end
  end
  # Рыба может менять направление
  def rotate! ()
    index = (@@directions.index(@orientation)+rand(@@directions.length-1)+1).modulo(@@directions.length)
    @orientation = @@directions[index]
  end

  # Рыба умеет плавать
  def swim! ()
    case @orientation
    when :up
      @coordinates[:y] += rand(@speed)+1
    when :down
      @coordinates[:y] += -rand(@speed)-1
    when :right
      @coordinates[:x] += rand(@speed)+1
    when :left
      @coordinates[:x] += -rand(@speed)-1
    else
      puts("Wrong orientation: #{@orientation.to_s}")
    end
  end
  # Можно проверить жива рыба или нет?
  def is_alive?
    if @state == :alive then true
    else false
    end
  end
  # Можно узнать координаты рыбы
  def get_coords
    @coordinates
  end
  # И напечатать координаты рыбы
  def print_coords
    puts ("#{@coordinates[:x]} #{@coordinates[:y]}")
  end
  # Можно узнать направление рыбы
  def print_orientation
    @orientation
  end
  # Напечатать ориентацию
  def print_orientation
    puts(@orientation.to_s)
  end
  def get_fish_view
    if is_alive?
      @@fish_models[@orientation]
    else
      @@dead_fish_models[@orientation]
    end
  end
  # Рыбу можно убить ><x>
  def kill_fish!
      @state = :dead
  end
end
