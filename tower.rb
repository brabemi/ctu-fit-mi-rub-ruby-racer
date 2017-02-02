require_relative './player'
require_relative './wood_block'
require_relative './moss_block'
require_relative './brick_block'
require_relative './pause'
require_relative './bomb'
require_relative './coin'
require_relative './ruby'

class Tower
  def initialize(game)
    @game = game
    @width = game.width
    @height = game.height
    # get from block, width and height
    @block_size = 50
    @blocks = []
    @power_ups = []
    @width_in_blocks = @width/@block_size
    @last_line = 0
    @prng = Random.new
    @player = Player.new(@width/2, 5.1*@block_size, @game)
    5.times { |_| generate_row }
  end

  def generate_row
    block_type = @prng.rand(0...7)
    if block_type == 0
      block = Object.const_get('BrickBlock')
    elsif block_type == 1
      block = Object.const_get('MossBlock')
    else
      block = Object.const_get('WoodBlock')
    end

    y = @last_line
    last = @width_in_blocks - 1
    @blocks << block.new(0, y, false) << block.new(last*@block_size, y, false)

    if @prng.rand > 0.8
      powerup_type = @prng.rand(0...15)
      if powerup_type < 3
        poweup = Object.const_get('Pause')
      elsif powerup_type < 6
        poweup = Object.const_get('Bomb')
      elsif powerup_type < 7
        poweup = Object.const_get('Ruby')
      else
        poweup = Object.const_get('Coin')
      end
      x = (1+((@width_in_blocks-3)*@prng.rand))*@block_size
      @power_ups << poweup.new(x, y+20, @game)
    end

    y += @block_size
    @blocks << block.new(0, y, false) << block.new(last*@block_size, y, false)
    hole = @prng.rand(0...@width_in_blocks-3)
    (@width_in_blocks-2).times { |i| (@blocks << block.new((i+1)*@block_size, y)) if i<hole || i> hole+1 }

    y += @block_size
    @blocks << block.new(0, y, false) << block.new(last*@block_size, y, false)
    @last_line = y + @block_size
  end

  def draw
    @player.draw
    @blocks.each { |e| e.draw }
    @power_ups.each { |e| e.draw }
  end

  def detonation(radius)
    x = @player.x + @player.width/2
    y = @player.y + @player.height
    @blocks.select! do |b|
      b_x = b.x + b.width/2
      b_y = b.y + b.height/2
      next !b.destructible || (x - b_x)**2 + (y - b_y)**2 > radius**2
    end
  end

  def flash
    y = @last_line
    while (y + 1.1*@block_size) > @height
      y -= 3*@block_size
    end
    @player.flash(@width/2, y+@block_size - 1.2*@player.height)
  end

  def update_delta(delta, rolled)
    if @last_line < (@height + 4*@block_size)
      generate_row
      @blocks.select! { |e| e.y >= -1 * @block_size }
      @power_ups.select! { |e| e.y >= -1 * @block_size || !e.used }
    end
    @last_line -= rolled
    @player.update_delta(delta, rolled, @blocks)
    @blocks.each { |e| e.update_delta(delta, rolled) }
    @power_ups.each { |e| e.update_delta(delta, rolled, @player) }
  end
end
