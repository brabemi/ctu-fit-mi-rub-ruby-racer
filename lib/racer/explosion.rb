require 'gosu'

class Explosion
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
    @scale = 1.2
    @anim_speed = 70
    @base_path = File.expand_path('../../..', __FILE__) + '/'
    @frames = Gosu::Image::load_tiles(@base_path + 'media/power_ups/explosion.png', 64, 64)
    @height = @frames[0].height
    @width = @frames[0].width
    @frame = 0
    @last_frame_change = Gosu::milliseconds
  end

  def height
    @scale*@height
  end

  def width
    @scale*@width
  end

  def update_delta(delta, rolled)
    @y -= rolled
  end

  def draw
    if Gosu::milliseconds - @last_frame_change > @anim_speed
      @frame += 1
      @last_frame_change = Gosu::milliseconds
    end
    if @frame < @frames.length
      @frames[@frame].draw(@x-self.width/2, @y, 1, @scale, @scale)
    end
  end
end
