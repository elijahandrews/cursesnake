class Tile
  attr_accessor :char, :traversable

  def draw x , y
    Curses.setpos x, y
    Curses.addstr @char
  end
end

