
=begin
      This source file contains code for all the game interface elements and routines.
      A lot of it is currently really placeholderish stuff but eventually it'll be unfucked and you'll have
      all you need to make any kind of UI element!  
=end

module UI_CONST
  STAT_WIDTH = 29
  STAT_HEIGHT = 8
  WINDOW_Z = 10
end


class UserInterface
  
  attr_accessor :tileHeight
  attr_accessor :tileWidth
  attr_accessor :x
  attr_accessor :y
  
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
    @x = x
    @y = y
    @image = Gosu::Image.load_tiles("Graphics/UI-Window.png", @@uiTileSize, @@uiTileSize, :retro => true)
  end
  
  def draw
    # First drawing the corners
    @image[0].draw(@x, @y, @zOrder)
    @image[0].draw(@x + @width, @y, @zOrder)
    @image[0].draw(@x, @y + @height, @zOrder)
    @image[0].draw(@x + @width, @y + @height, @zOrder)
    
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
  
  
end