require './drawable.rb'

class Character < Drawable

  def initialize(y, x, char)
    @y = y
    @x = x
    @char = char
    draw
  end

   def move(y, x)
    Display.draw @y, @x, ' '
    @y += y
    @x += x
    draw
  end

end
