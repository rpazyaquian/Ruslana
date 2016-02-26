
=begin
      This source file contains code for all the game interface elements and routines.
      A lot of it is currently really placeholderish stuff but eventually it'll be unfucked and you'll have
      all you need to make any kind of UI element!  
=end

module UI_CONST
  STAT_WIDTH = 29
  STAT_HEIGHT = 8
  WINDOW_Z = 10
  DEBUG_TIP = "DEBUG MODE"
end


class UserInterfaceWindow
  
  attr_accessor :tileHeight
  attr_accessor :tileWidth
  attr_accessor :x
  attr_accessor :y
  attr_accessor :focus
  attr_accessor :tip
  
  def initialize(window, width, height, x, y, zOrder)
    ################################################################
    # Always define width and height in number of expected tiles!  #
    ################################################################
    @@uiTileSize = 8
    @zOrder = zOrder
    @tileWidth = width
    @tileHeight = height
    @width = width * @@uiTileSize
    @height = height * @@uiTileSize
    @window = window
    @x, @y = x, y

    @image = Gosu::Image.load_tiles("Graphics/UI-Window.png", @@uiTileSize, @@uiTileSize, :retro => true)
    @font  = Gosu::Font.new(16, :name => "Graphics/Perfect DOS VGA 437.ttf")
    @focus = false
    
    @tip = "WELCOME!"
  end
  
  def draw
    # First drawing the corners
    @image[0].draw(@x, @y, @zOrder)
    @image[2].draw(@x + @width, @y, @zOrder)
    @image[6].draw(@x, @y + @height, @zOrder)
    @image[8].draw(@x + @width, @y + @height, @zOrder)
    
    # Now drawing the borders
    for i in 0..@tileWidth
      @image[1].draw(@x + (i*@@uiTileSize), @y, (@zOrder - 1))
      @image[7].draw(@x + (i*@@uiTileSize), @y + @height, (@zOrder - 1))
    end
    
    for i in 0..@tileHeight
      @image[3].draw(@x, @y + (i*@@uiTileSize), (@zOrder - 1))
      @image[5].draw(@x + @width, @y + (i*@@uiTileSize), (@zOrder - 1))
    end
    
    # Time to fill the window!

    for v in 0..@tileHeight
      for h in 0..@tileWidth
        @image[4].draw(@x + (h*@@uiTileSize), @y + (v*@@uiTileSize), (@zOrder - 2), 1, 1)
      end
    end
  end
  
  def show(text)
    @font.draw(text,@x + 10,@y + 10, @zOrder)
  end
 
 
#=====================================================
#   Window update and system stack.
#       Maybe we can push/pop window states and focus!
#=====================================================
  def update
    if @focus == false then 
        return
    end
    
    if @window.button_down? Gosu::KbDown
        @y +=2
    end
    
    if @window.button_down? Gosu::KbRight
        @x +=2
    end
    
    if @y > @window.height
        @y = 0
    end
    
    if @x > @window.width
        @x = 0
    end
  end
  
  
end

#=====================================================
#   Mouse cursor class
#       This should control which element has focus
#       
#   The states are as follows:
#       0- Regular pointer state
#       1- Translation state
#       2- Will be added
#       3- Will be added
#=====================================================

class MouseCursor
    attr_reader :y
    attr_reader :x
    
    def initialize(window)
        @@window = window
        @@pointersize = 16
        p = @@pointersize
        @pointer = Gosu::Image.load_tiles("Graphics/UI-Cursors.png", p, p, :retro => true)
        @state = 0
        @x = 0
        @y = 0
        @z = 10
        @old_x, @old_y = 0 , 0
    end
    
    def draw
        @pointer[@state].draw(@x,@y,@z)
    end
        
    def update
        @x = @@window.mouse_x
        @y = @@window.mouse_y
        
        #======================================#
        #   Hold down RMB to move the camera   #
        #======================================#
        if @@window.button_down? Gosu::MsRight
            @state = 1
            @@window.uiWindow.tip = "MOVING"
            @@window.camera_x = @old_x + (@x - @origin_x)
            @@window.camera_y = @old_y + (@y - @origin_y)
            return
        end
        @state = 0
        @old_x, @old_y = @@window.camera_x, @@window.camera_y
        @origin_x = @x
        @origin_y = @y
        
        
    end
    
end