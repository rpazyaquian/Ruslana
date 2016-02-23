require 'rubygems'
require 'gosu'

require_relative 'Source/Interface'

class GameWindow < Gosu::Window
  
  def initialize
    super 640, 400, false
    self.caption = 'Ruslana'
    @uiWindow = UserInterface.new(self, UI_CONST::STAT_WIDTH, UI_CONST::STAT_HEIGHT, 0, 0, UI_CONST::WINDOW_Z)
  end
  
  def draw
    
    if @uiWindow != nil then
      @uiWindow.draw
    end
    
  end
  
  def update
    
    
  end
  
end

window = GameWindow.new
window.show