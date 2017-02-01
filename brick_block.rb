require_relative './block'
class BrickBlock < Block
  def initialize(x, y, destructible = true)
    super(x, y, destructible)
    @scale = 0.10
    @block = Gosu::Image::new('media/blocks/brick.png')
    @width = @block.width
    @height = @block.height
    @speed_modif = 1.25
  end
end
