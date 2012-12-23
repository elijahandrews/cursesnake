class Entity
  attr_accessor :y, :x, :char

  def draw
    Display.draw @y, @x, @char
  end
end

