require_relative './block'
class BrickBlock < Block
  def initialize(x, y, destructible = true)
    super(x, y, destructible)
    @destructible = false
    @scale = 0.10
    @block = Gosu::Image::new(@base_path + 'media/blocks/brick.png')
    @width = @block.width
    @height = @block.height
    @speed_modif = 1.25
  end
end
