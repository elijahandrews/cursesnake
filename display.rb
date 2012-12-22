require 'curses'

# Use SW/SH when traversing through the screen, and SCREEN_WIDTH
# and SCREEN_HEIGHT when creating the array
SCREEN_WIDTH = 90
SW = SCREEN_WIDTH - 1
SCREEN_HEIGHT = 40
SH = SCREEN_HEIGHT - 1

def init_screen
  Curses.noecho
  Curses.init_screen
  Curses.curs_set 0
  Curses.stdscr.keypad(true)
  begin
    yield
  ensure
    Curses.close_screen
  end
end

def initiate_tiles
   @tiles = Array.new(SCREEN_HEIGHT){ Array.new(SCREEN_WIDTH){ Tile.new } }

   (0..SH).each do |i|
     (0..SW).each do |j|
       tile = @tiles[i][j]
      if i == 0 || i == SH
        tile.char = '-'
        tile.traversable = false
      elsif j == 0 || j == SW
        tile.char = '|'
        tile.traversable = false
      else
        tile.char = ' '
        tile.traversable = true
      end

       tile.draw i, j
    end
  end
end
