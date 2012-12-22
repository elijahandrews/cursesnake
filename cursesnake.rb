require './display.rb'
require './tile.rb'
require './drawable.rb'

Display::init_screen do
  Display::initiate_tiles
  Curses.refresh
  loop{}
end

