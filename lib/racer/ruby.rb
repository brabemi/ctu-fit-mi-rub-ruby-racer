require_relative './power_up'

class Ruby < PowerUP
  attr_reader :x, :y, :used

  def initialize(x, y, game)
    super(x, y, game)
    @scale = 0.03
    @frames = [Gosu::Image::new(@base_path + 'media/power_ups/ruby.png')]
    @height = @frames[0].height
    @width = @frames[0].width
  end

  def action
    @game.add_ruby()
  end
end
