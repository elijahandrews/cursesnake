require './display.rb'
require './tile.rb'
require './entity.rb'
require './character.rb'
require 'io/wait'

def char_if_pressed
  begin
    system("stty raw -echo") # turn raw input on
    c = nil
    if $stdin.ready?
      c = $stdin.getc
    end
    c.chr if c
  ensure
    system "stty -raw echo" # turn raw input off
  end
end


Display::init_screen do
  Curses.timeout = 0
  Display::initiate_tiles
  char = Character.new 20, 20, '@', [0,0]
  Curses.refresh
  loop do
    c = Curses.getch
    unless c.nil?
      case c
      when Curses::Key::UP    then char.set_velocity [-1,0]
      when Curses::Key::DOWN  then char.set_velocity [1,0]
      when Curses::Key::RIGHT then char.set_velocity [0, 1]
      when Curses::Key::LEFT  then char.set_velocity [0,-1]
      when (?q) then break
      end
    end
    break unless char.move_by_velocity_if_valid
    Curses.refresh
    sleep(0.1)
  end
end

