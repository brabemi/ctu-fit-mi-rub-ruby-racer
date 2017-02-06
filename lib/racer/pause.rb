require_relative './power_up'

class Pause < PowerUP
  def initialize(x, y, game)
    super(x, y, game)
    @scale = 0.45
    @frames = [Gosu::Image::new(@base_path + 'media/power_ups/pause.png')]
    @height = @frames[0].height
    @width = @frames[0].width
  end

  def action
    @game.add_pause
  end
end
