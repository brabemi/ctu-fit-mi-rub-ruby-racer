require_relative './power_up'

class Bomb < PowerUP
  attr_reader :x, :y, :used

  def initialize(x, y, game)
    super(x, y, game)
    @scale = 0.12
    @frames = [Gosu::Image::new('media/power_ups/bomb.png')]
    @height = @frames[0].height
    @width = @frames[0].width
  end

  def action
    @game.add_bomb()
  end
end
