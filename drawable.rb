class Drawable
  attr_accessor :char

  def draw x , y
    Curses.setpos x, y
    Curses.addstr @char
  end
end

