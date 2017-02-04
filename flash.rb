require 'gosu'

class Flash
  attr_reader :x, :y

  def initialize(x, y)
    @x, @y = x, y
    @scale = 1.2
    @anim_speed = 20
    @frames = Gosu::Image::load_tiles('media/power_ups/flash.png', 128, 128)
    @height = @frames[0].height
    @width = @frames[0].width
    @frame = 2
    @last_frame_change = Gosu::milliseconds
  end

  def height
    @scale*@height
  end

  def width
    @scale*@width
  end

  def update_delta(delta, rolled, player)
    @y -= rolled
  end

  def draw
    if Gosu::milliseconds - @last_frame_change > @anim_speed
      @frame += 1
      @last_frame_change = Gosu::milliseconds
    end
    if @frame < @frames.length
      @frames[@frame].draw(@x-self.width/2, @y-(3*self.height/4), 1, @scale, @scale)
    end
  end
end
