require 'gosu'

class Player
  attr_reader :x, :y

  def initialize(x, y, game)
    @x, @y = x, y
    @game = game
    @scale = 0.12
    @speed = 250
    @anim_speed = 150
    @fall_speed = 300
    @base_path = File.expand_path('../../..', __FILE__) + '/'
    @right = { idle: [], run: [], jump_up: [Gosu::Image::new(@base_path + 'media/character/jump up/frame.png')],
      jump_fall: [Gosu::Image::new(@base_path + 'media/character/jump fall/frame.png')] }
    2.times { |i| @right[:idle] << Gosu::Image::new(@base_path + "media/character/idle/frame-#{i+1}.png") }
    4.times { |i| @right[:run] << Gosu::Image::new(@base_path + "media/character/run/frame-#{i+1}.png") }
    @left = { idle: [], run: [], jump_up: [Gosu::Image::new(@base_path + 'media/character/jump up/l-frame.png')],
      jump_fall: [Gosu::Image::new(@base_path + 'media/character/jump fall/l-frame.png')] }
    2.times { |i| @left[:idle] << Gosu::Image::new(@base_path + "media/character/idle/l-frame-#{i+1}.png") }
    4.times { |i| @left[:run] << Gosu::Image::new(@base_path + "media/character/run/l-frame-#{i+1}.png") }
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

  def flash(x, y)
    @x = x
    @y = y
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
      if ((b.x+b.width) >= @x) && (b.x < (@x+self.width))
        return b.speed_modif if (b.y < @y+self.height) && (b.y+b.height > @y+self.height)
        return 1 if (b.y < @y) && (b.y+b.height > @y)
      end
    end
    0
  end

  def update_delta(delta, rolled, blocks)
    y_old = @y

    if @fall_speed >= 300
      @fall_speed = -150 if Gosu::button_down? Gosu::KbSpace
    else
       @fall_speed += 300*delta
    end

    @y += delta * @fall_speed

    @fall_speed<0 ? @state = :jump_up : @state = :jump_fall

    speed_modif = 1
    coll_res = collide_y(blocks)
    if coll_res > 0
      speed_modif = coll_res
      @y = y_old
      @state = :idle
      @fall_speed = 300
    end
    @y = y_old if @y+self.height > @game.height

    x_old = @x
    distance = speed_modif * delta * @speed
    if Gosu::button_down? Gosu::KbLeft
      @x -= distance
      @state = :run if @state == :idle
      @direction = @left
    end
    if Gosu::button_down? Gosu::KbRight
      @x += distance
      @state = :run if @state == :idle
      @direction = @right
    end
    @x = x_old if collide_x(blocks)

    @y -= rolled

    @game.out_of_screen if @y + self.height < 0
  end

  def draw
    action = @direction[@state]
    frame = action[Gosu::milliseconds / @anim_speed % action.size]
    # @direction[@state][Gosu::milliseconds / @anim_speed % @direction[@state].size].draw(@x, @y, 0, @scale, @scale)
    # @width = frame.width
    # @height = frame.height
    frame.draw(@x, @y, 0, @scale, @scale)
  end
end
