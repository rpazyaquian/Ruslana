
=begin
      
      This is where all the code for playable and unplayable entities goes. Maybe they're controlled by AI, hahah.
        
=end

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
  TILE = 40
end

class Map
  
  def initialize(mapfile)
    @layout = setup(mapfile)
    
  end
  
  def load(mapfile)
    #mapdata = File.readlines("Maps/#{mapfile}.NKM", "r") do
  end
  
end