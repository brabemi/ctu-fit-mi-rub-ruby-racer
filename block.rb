class Block
  attr_reader :x, :y, :scale

  def initialize(x, y, destructable = true)
    @x = x
    @y = y
    @destructable = destructable
    @scale = 0.10
    @block = Gosu::Image::new('media/blocks/wood.png')
    @width = @block.width
    @height = @block.height
  end

  def height
    @scale*@height
  end

  def width
    @scale*@width
  end

  def draw
    @block.draw(@x, @y, 0, @scale, @scale)
  end

  def update_delta(delta, rolled)
    @y -= rolled
  end
end
