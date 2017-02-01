class Block
  attr_reader :x, :y, :scale

  def initialize(x, y, destructable = true)
    @x = x
    @y = y
    @destructable = destructable
    @scale = 0.15
    @block = Gosu::Image::new('media/blocks/wood.png')
  end

  def draw
    @block.draw(@x, @y, 0, @scale, @scale)
  end

  def update_delta(delta, rolled)
    @y -= rolled
  end
end
