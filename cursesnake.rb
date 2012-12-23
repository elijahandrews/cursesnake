require './display.rb'
require './tile.rb'
require './entity.rb'
require './character.rb'

Display::init_screen do
  Display::initiate_tiles
  Curses.refresh
  char = Character.new 20, 20, '@'
  loop do
    case Curses.getch
    when Curses::Key::UP then char.move(-1,0)
    when Curses::Key::DOWN then char.move(1,0)
    when Curses::Key::RIGHT then char.move(0,1)
    when Curses::Key::LEFT then char.move(0,-1)
    when (?q) then break
    end
  end
end

