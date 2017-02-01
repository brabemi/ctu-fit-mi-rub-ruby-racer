require_relative './block'
class MossBlock < Block
  def initialize(x, y, destructible = true)
    super(x, y, destructible)
    @scale = 0.10
    @block = Gosu::Image::new('media/blocks/moss.png')
    @width = @block.width
    @height = @block.height
    @speed_modif = 0.75
  end
end
