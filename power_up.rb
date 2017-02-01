class Pause
  attr_reader :x, :y, :used

  def initialize(x, y, game)
    @x, @y = x, y
    @game = game
    @scale = 0.5
    @used = false
    @anim_speed = 200
    @frames = [Gosu::Image::new('media/power_ups/pause.png')]
    @height = @frames[0].height
    @width = @frames[0].width
    @pause_length = 3
  end

  def height
    @scale*@height
  end

  def width
    @scale*@width
  end

  def collide(player)
    unless used
      x_mid = @x + self.width/2
      y_mid = @y + self.height/2
      if x_mid > player.x && x_mid < player.x + player.width &&
         y_mid > player.y && y_mid < player.y + player.height
        @used = true
        @game.stop_time(@pause_length)
      end
    end
  end

  def update_delta(delta, rolled, player)
    @y -= rolled
    self.collide(player)
  end

  def draw
    unless @used
      frame = @frames[Gosu::milliseconds / @anim_speed % @frames.size]
      frame.draw(@x, @y, 1, @scale, @scale)
      @height = frame.height
      @width = frame.width
    end
  end
end
