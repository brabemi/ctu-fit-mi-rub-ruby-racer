require_relative './block'
class WoodBlock < Block
  def initialize(x, y, destructible = true)
    super(x, y, destructible)
    @scale = 0.10
    @block = Gosu::Image::new('media/blocks/wood.png')
    @width = @block.width
    @height = @block.height
    @speed_modif = 1
  end
end
