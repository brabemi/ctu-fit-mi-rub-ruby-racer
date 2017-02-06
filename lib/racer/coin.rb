require_relative './power_up'

class Coin < PowerUP
  def initialize(x, y, game)
    super(x, y, game)
    @scale = 0.75
    @base_path = File.expand_path('../../..', __FILE__) + '/'
    @frames = Gosu::Image::load_tiles(@base_path + 'media/power_ups/coin.png', 40, 40)
    @height = @frames[0].height
    @width = @frames[0].width
    @anim_speed = 100
  end

  def action
    @game.add_coin()
  end
end
