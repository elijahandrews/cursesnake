require './display.rb'
require './tile.rb'

init_screen do
  initiate_tiles
  Curses.refresh
  loop{}
end

