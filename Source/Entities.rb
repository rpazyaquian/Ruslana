
#===============================================
#
# => Game Actors and statistics
#
#===============================================


class Actor
  # A class where all the statted-out entities lie. Not sure how the game will work going forward but the player can be one such entity.
  def initialize(playable)
    @playable = playable
    @resources = Resources.new
  end
  
end

class Resources
  attr_accessor :inventory
  attr_accessor :equipped
  # A class which controls inventories, equipment, and skills of an Actor instance.
  # TODO: add actual values to the equipment hash
  def initialize
    @equipped = {:armour => 0, :weapon => 0, :spell => 0}
  end
  
end


#===============================================
#
# => Map functions
#
#===============================================

module GameMaps
  Tilesize = 40
end

class Map
  attr_accessor :trans_x
  attr_accessor :trans_y
  
  #=====================================#
  #     The attributes allow
  #     map elements to be panned
  #     by the window camera
  #=====================================#
  
  def initialize(mapfile)
    @layout = load(mapfile)
    @tiles = Gosu::Image.load_tiles(@layout[:tilesets][0][:image], 40,40, :retro => true )
    
  end
  
  def load(mapfile)
    
    #This function loads the initial values into the map for usage.
    
    file = File.open("Maps/" + mapfile + ".json", 'r')
    layout = file.read
    file.close
    return JSON.parse(layout, :symbolize_names => true)
    
    #The names are symbolized to make reading the hash easier for me.
  end

  
  def draw
    
    #=====================================#
    #   The map is only two layers deep,  #
    # so there is no reason to loop calls #
    # to the drawlayer method.            #
    #=====================================#
    
    drawlayer(0)
    drawlayer(1)
    
  end
  
  def drawlayer(layer)
    for y in 0..@layout[:height]
        for x in 0..@layout[:width]
            tile = @layout[:layers][layer][:data][(y*@layout[:width]) + x - 1]
            if tile.nil?
                @tiles[0].draw(x * GameMaps::Tilesize + @trans_x, y *GameMaps::Tilesize, 0)
            else
                @tiles[tile - 1].draw(x * GameMaps::Tilesize + @trans_x, y *GameMaps::Tilesize + @trans_y, 0)
            end
        end
     end
  end
  
end