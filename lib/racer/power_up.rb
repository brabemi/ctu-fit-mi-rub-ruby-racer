require 'gosu'

class PowerUP
  attr_reader :x, :y, :used

  def initialize(x, y, game)
    @x, @y = x, y
    @game = game
    @scale = 1
    @used = false
    @anim_speed = 200
    @frames = []
    @height = 0
    @width = 0
    @base_path = File.expand_path('../../..', __FILE__) + '/'
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
        self.action
      end
    end
  end

  def action
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
