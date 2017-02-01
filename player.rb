class Player
  attr_accessor :x, :y

  def initialize(x, y, game)
    @x, @y = x, y
    @game = game
    @scale = 0.125
    @speed = 250
    @anim_speed = 150
    @fall_speed = 300
    @right = { idle: [], run: [], jump_up: [Gosu::Image::new('media/character/jump up/frame.png')],
      jump_fall: [Gosu::Image::new('media/character/jump fall/frame.png')] }
    2.times { |i| @right[:idle] << Gosu::Image::new("media/character/idle/frame-#{i+1}.png") }
    4.times { |i| @right[:run] << Gosu::Image::new("media/character/run/frame-#{i+1}.png") }
    @left = { idle: [], run: [], jump_up: [Gosu::Image::new('media/character/jump up/l-frame.png')],
      jump_fall: [Gosu::Image::new('media/character/jump fall/l-frame.png')] }
    2.times { |i| @left[:idle] << Gosu::Image::new("media/character/idle/l-frame-#{i+1}.png") }
    4.times { |i| @left[:run] << Gosu::Image::new("media/character/run/l-frame-#{i+1}.png") }
    @state = :idle
    @direction = @right
    @width = @direction[@state][0].width
    @height = @direction[@state][0].height
  end

  def height
    @scale*@height
  end

  def width
    @scale*@width
  end

  def collide_x(blocks)
    blocks.each do |b|
      if (b.y+b.height >= @y) && (b.y < @y+self.height)
        return true if (b.x < @x+self.width) && (b.x+b.width > @x+self.width)
        return true if (b.x < @x) && (b.x+b.width > @x)
      end
    end
    false
  end

  def collide_y(blocks)
    blocks.each do |b|
      if (b.x+b.width >= @x) && (b.x < @x+self.width)
        return true if (b.y < @y+self.height) && (b.y+b.height > @y+self.height)
        return true if (b.y < @y) && (b.y+b.height > @y)
      end
    end
    false
  end

  def update_delta(delta, rolled, blocks)
    y_old = @y
    @y += delta * @fall_speed
    @state = :jump_fall
    if collide_y(blocks)
      @y = y_old
      @state = :idle
    end
    @y = y_old if @y+self.height > @game.height
    x_old = @x
    distance = delta * @speed
    # @state = :idle
    if Gosu::button_down? Gosu::KbLeft
      @x -= distance
      @state = :run
      @direction = @left
    end
    if Gosu::button_down? Gosu::KbRight
      @x += distance
      @state = :run
      @direction = @right
    end
    @x = x_old if collide_x(blocks)

    @y -= rolled
  end

  def draw
    action = @direction[@state]
    frame = action[Gosu::milliseconds / @anim_speed % action.size]
    @width = frame.width
    @height = frame.height
    frame.draw(@x, @y, 0, @scale, @scale)
  end
end
