require 'rubygems'
require 'gosu'
require 'json'

require_relative 'Source/Interface'
require_relative 'Source/Entities'

class GameWindow < Gosu::Window
  
  def initialize
    super 640, 400, false
    self.caption = 'Ruslana'
    @map = Map.new("MockMap")
    @uiWindow = UserInterfaceWindow.new(self, UI_CONST::STAT_WIDTH, UI_CONST::STAT_HEIGHT, 0, 0, UI_CONST::WINDOW_Z)
    @cursor = MouseCursor.new(self)
  end
  
  def draw
    
    if @uiWindow then
      @uiWindow.draw
      @uiWindow.show("GREETINGS! LET'S PLAY!")
    end
    
    @map.draw
    @cursor.draw
    
  end
  
  #=======================================
  #  For the sake of tidyness, try
  #  to keep control data out of the
  #  update method for the window itself;
  #  let the objects handle their own
  #  using a "focus" boolean.
  #=======================================
  
  def update
    
    if @uiWindow then
        @cursor.update
        @uiWindow.update
    end
  end
  
end

window = GameWindow.new
window.show