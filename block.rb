class Block
  attr_reader :x, :y, :scale, :speed_modif, :destructible

  def initialize(x, y, destructible = true)
    @x = x
    @y = y
    @destructible
    @scale = 0
    @block = nil
    @width = 0
    @height = 0
    @speed_modif = 1
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
