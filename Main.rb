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
    @uiWindow = UserInterface.new(self, UI_CONST::STAT_WIDTH, UI_CONST::STAT_HEIGHT, 0, 0, UI_CONST::WINDOW_Z)
  end
  
  def draw
    
    if @uiWindow != nil then
      @uiWindow.draw
    end
    
    @map.draw(0)
    
  end
  
  def update
    
    
  end
  
end

window = GameWindow.new
window.show