require 'rubygems'
require 'gosu'

require_relative 'Source/Interface'

class GameWindow < Gosu::Window
  
  def initialize
    super 640, 400, false
    self.caption = 'Ruslana'
    @uiWindow = UserInterface.new(self,50,20,0,0, 7)
  end
  
  def draw
    @uiWindow.draw
  end
  
  def update
    
    if button_down? Gosu::KbDown then
      @uiWindow.resize(0,1)
    end
    
    if button_down? Gosu::KbUp then
      @uiWindow.resize(0,-1)
    end
    
    if button_down? Gosu::KbRight then
      @uiWindow.resize(1,0)
    end
    
    if button_down? Gosu::KbLeft then
      @uiWindow.resize(-1,0)
    end
    
  end
  
end

window = GameWindow.new
window.show