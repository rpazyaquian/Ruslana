require 'rubygems'
require 'gosu'
require 'json'

require_relative 'Source/Interface'
require_relative 'Source/Entities'

class GameWindow < Gosu::Window
  attr_accessor     :camera_x
  attr_accessor     :camera_y
  attr_accessor     :uiWindow
  def initialize
    super 960, 600, false
    self.caption = 'Ruslana'
    @map = Map.new("MockMap")
    @uiWindow = UserInterfaceWindow.new(self, UI_CONST::STAT_WIDTH, UI_CONST::STAT_HEIGHT, 0, 0, UI_CONST::WINDOW_Z)
    @cursor = MouseCursor.new(self)
    @camera_x , @camera_y = 0 , 0
  end
  
  def draw
    
    if @uiWindow then
      @uiWindow.draw
      @uiWindow.show(@uiWindow.tip)
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
    @map.trans_x, @map.trans_y = @camera_x , @camera_y
    @cursor.update
    if @uiWindow then
        @uiWindow.update    
    end
    bind_camera
  end
  
  #=======================================
  #  This method binds the camera within
  #  the boundaries of the map to keep
  #  it in view.
  #=======================================
  
  def bind_camera
    pad_TL = GameMaps::Tilesize * 2
    pad_BR = GameMaps::Tilesize * 6
    if @camera_y > pad_TL
       @camera_y = pad_TL
    end
    if @camera_x > pad_TL
       @camera_x = pad_TL
    end
    if @camera_y < (@map.pix_height * - 1) + pad_BR
        @camera_y = (@map.pix_height * - 1) + pad_BR
    end
    if @camera_x < (@map.pix_width * - 1) + pad_BR
        @camera_x = (@map.pix_width * - 1) + pad_BR
    end
  end
  
end

window = GameWindow.new
window.show