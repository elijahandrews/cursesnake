require './display.rb'
require './tile.rb'
require './entity.rb'
require './character.rb'

def generate_food(char, previous_tail = [])
  y, x = 0
  loop do
    y = Random.rand(Display::SH) + 1
    x = Random.rand(Display::SW) + 1
    break unless char.positions.include?([y,x]) ||
      !Display.instance_variable_get(:@tiles)[y][x].traversable ||
      (!previous_tail.empty? && previous_tail == [y,x])
  end
  Display.draw y, x, '#'
  return [y,x]
end


Display::init_screen do
  score = 0
  Curses.timeout = 0
  Display::initiate_tiles
  char = Character.new 20, 20, '@', [0,0]
  food_position = generate_food(char)
  Curses.refresh
  loop do
    c = Curses.getch
    unless c.nil?
      case c
      when Curses::Key::UP    then char.set_velocity [-1,0]
      when Curses::Key::DOWN  then char.set_velocity [1,0]
      when Curses::Key::RIGHT then char.set_velocity [0, 1]
      when Curses::Key::LEFT  then char.set_velocity [0,-1]
      when (?q) then break
      end
    end
    previous_tail = char.move_by_velocity_if_valid
    break unless previous_tail
    if previous_tail != [] && char.positions.first == food_position
      food_position = generate_food(char, previous_tail)
      char.add_tail(previous_tail)
      score += 1
    end
    Curses.refresh
    sleep(0.1)
  end
end

