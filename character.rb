require './entity.rb'

class Character < Entity
  attr_accessor :velocity # [y_offset, x_offset]

  def initialize(y, x, char, velocity)
    @y = y
    @x = x
    @char = char
    @velocity = velocity
    draw
  end

  def move_by_velocity
    # Consider refactoring Display to be in instance of an object instead of a static class
    y_offset = velocity.first
    x_offset = velocity.last
    if Display.instance_variable_get(:@tiles)[@y+y_offset][@x+x_offset].traversable
      Display.draw @y, @x, ' '
      @y += y_offset
      @x += x_offset
      draw
    end
  end

end
