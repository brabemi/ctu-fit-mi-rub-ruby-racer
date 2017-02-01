class Player
  attr_reader :x, :y

  def initialize
    @x, @y = 100, 200
    @scale = 0.25
    @speed = 200
    @anim_speed = 200
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
  end

  def update_delta(delta, rolled)
    distance = delta * @speed
    @y -= rolled
    @state = :idle
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
  end

  def draw
    action = @direction[@state]
    action[Gosu::milliseconds / @anim_speed % action.size].draw(@x, @y, 0, @scale, @scale)
  end
end
