require './display.rb'
require './tile.rb'
require './entity.rb'
require './character.rb'
require './score_window.rb'

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
  loop do
    Display::initiate_tiles
    char = Character.new 20, 30, '@', [0,1], 20
    food_position = generate_food(char)
    Curses.refresh

    score_window = ScoreWindow.new Curses.lines / 3, Curses.cols - 15

    sleep(0.5)

    loop do
      c = Curses.getch
      unless c.nil?
        case c
        when Curses::Key::UP    then char.set_velocity [-1,0]
        when Curses::Key::DOWN  then char.set_velocity [1,0]
        when Curses::Key::RIGHT then char.set_velocity [0,1]
        when Curses::Key::LEFT  then char.set_velocity [0,-1]
        when (?q) then break
        end
      end
      previous_tail = char.move_by_velocity_if_valid
      break unless previous_tail
      if previous_tail != [] && char.positions.first == food_position
        food_position = generate_food(char, previous_tail)
        char.add_tail(previous_tail)
        score_window.score += 1
        score_window.write_score
      end
      Curses.refresh
      sleep(0.05)
    end

    Curses.setpos(Display::SCREEN_HEIGHT/2 - 5,Display::SCREEN_WIDTH/2 - 10)
    Curses.addstr "You scored #{score_window.score}!"
    Curses.setpos(Display::SCREEN_HEIGHT/2 - 4,Display::SCREEN_WIDTH/2 - 10)
    Curses.addstr "Play again? (y/n)"
    Curses.refresh
    Curses.timeout = 31337
    loop do
      c = Curses.getch
      exit if c == 'n' || c == 'q'
    end
    Curses.timeout = 0
  end
end

