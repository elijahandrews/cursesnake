require './entity.rb'

class Character < Entity
  attr_accessor :velocity # [y_offset, x_offset]
  attr_accessor :positions # [[head_y, head_x], ..., [tail_y, tail_x]]

  def initialize(y, x, char, velocity, length = 4)
    @positions = []
    length.times { |i| @positions << [y, x-i] }
    @char = char
    @velocity = velocity
    @positions.each do |p|
      Display.draw p.first, p.last, @char
    end
    # draw
  end

  def move_by_velocity_if_valid
    # Consider refactoring Display to be in instance of an object instead of a static class
    return true if velocity == [0,0]
    head = @positions.first
    tail = @positions.last
    new_y = velocity.first + head.first
    new_x = velocity.last + head.last

    tile_traversable = Display.instance_variable_get(:@tiles)[new_y][new_x].traversable
    collision_with_tail = @positions.include? [new_y, new_x]

    if tile_traversable && !collision_with_tail
      Display.draw tail.first, tail.last, ' '
      @positions.pop
      @positions.unshift [ new_y, new_x]
      Display.draw @positions.first.first, @positions.first.last, char
      return true
    end

    return false
  end

  def set_velocity(new_velocity)
    # Sets the velocity if the new velocity is not in the opposite direction
    @velocity = new_velocity unless new_velocity.map{ |i| i*-1 } == @velocity
  end

end
