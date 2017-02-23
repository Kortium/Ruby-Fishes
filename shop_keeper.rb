require './tank'
require './player'
require './helper'

class Shop_keeper
  def initialize
    @state = "Entered"
    @player = Player.new
    @character = 0
    @tank_sizes = {:x => 30, :y => 10}
  end
  def print_state
    Curses.addstr(@state)
  end

  def talk
    case @state
    when "Entered"
      greetings = generate_hello
      Curses.addstr(greetings)
      get_answer
    when "Pick Tank" # Try to use CONSTANT_STYLE instead of "String style" to conditions.
      question = generate_ask_tank_params
      Curses.addstr(question)
      get_answer
    when "Tank Error"
      question = generate_no_tank
      Curses.addstr(question)
      get_answer
    when "Pick fish number"
      question = generate_ask_fishes_number
      Curses.addstr(question)
      get_answer
    when "Ready"
      Curses.addstr("Tank Sizes #{@tank_sizes[:x]} #{@tank_sizes[:y]}
      Fishes #{@player.get_fishes}")
      Curses.getstr
    end
  end

  def generate_hello
    # this is good example to start using YAML for long string values.
    hello = ["Hi. What's you're name? ", "Good morning, what is your name? ", "Hallo! Haven't we met before? What is your name? "]
    @character = rand(3)
    hello[@character]
  end
  def generate_ask_tank_params
    tank_params = ["Hi #{@player.get_name}. You are here for the tank? What do you need? (enter length and height of the tank) ",
      "Good morning, #{@player.get_name}. What tank do you need? (enter length and height of the tank) ",
      "Hallo! #{@player.get_name}. Let's get started? (enter length and height of the tank) "]
    tank_params[@character]
  end
  def generate_no_tank
    tank_params = ["We're sorry but we don't have this one, may be another? (enter length and height of the tank) ",
      "Sorry but we don't have a tank to fit you criteria, may be another one? (enter length and height of the tank) ",
      "Ok pal! Huh? Stop. We don't have this tank pick another one... (enter length and height of the tank) "]
    tank_params[@character]
  end
  def generate_ask_fishes_number
    fish_number = ["How many fishes do you need? (enter fish number) ",
      "Ok, now we need to decide number of the fishes. (enter fish number) ",
      "Hehey we are on the finish line, fishes? (enter fish number) "]
    fish_number[@character]
  end

  def get_answer
    answer = Curses.getstr
    if answer == "Exit" then @state = "Exit" end
    case @state
    when "Entered"
      @player.set_name(answer)
      @state = "Pick Tank"
    when "Pick Tank", "Tank Error"
      @tank_sizes[:x] = answer.scan(/\d+/)[0].to_i
      @tank_sizes[:y] = answer.scan(/\d+/)[1].to_i
      if (@tank_sizes[:x]<10 || @tank_sizes[:y]<5 || @tank_sizes[:x]>60 || @tank_sizes[:y]>25) then
        @state = "Tank Error"
      else
        @state = "Pick fish number"
      end
    when "Pick fish number"
      fishes = answer.scan(/\d+/)[0].to_i
      if fishes == 0 then Curses.addstr("That's wierd but ok...") end
      @player.set_fishes(fishes)
      @state = "Ready"
    end
  end
end

steve = Shop_keeper.new
steve.talk
steve.talk
steve.talk
steve.talk
