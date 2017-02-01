require_relative './power_up'

class Coin < PowerUP
  attr_reader :x, :y, :used

  def initialize(x, y, game)
    super(x, y, game)
    @scale = 0.75
    @frames = Gosu::Image::load_tiles('media/power_ups/coin.png', 40, 40)
    @height = @frames[0].height
    @width = @frames[0].width
    @anim_speed = 100
  end

  def action
    @game.add_coin()
  end
end
