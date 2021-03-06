require 'curses'

class Display

  # Use SW/SH when traversing through the screen, and SCREEN_WIDTH
  # and SCREEN_HEIGHT when creating the array
  SCREEN_WIDTH = 70
  SW = SCREEN_WIDTH - 1
  SCREEN_HEIGHT = 30
  SH = SCREEN_HEIGHT - 1

  class << self

    def init_screen
      Curses.noecho
      Curses.init_screen
      Curses.curs_set 0
      Curses.timeout = 0
      Curses.stdscr.keypad(true)
      yield
      Curses.close_screen
    end

    def initiate_tiles
      # Note: Tiles currently correspond to map tiles. They do not
      # include the character or any other dynamic elements
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

          tile.x = j
          tile.y = i
          tile.draw
        end
      end
    end

    def draw(y, x, char)
      Curses.setpos y, x
      Curses.addstr char
    end

  end
end
