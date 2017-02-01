require_relative './block'

class Tower
  def initialize(game)
    @game = game
    @width = game.width
    @height = game.height
    # get from block, width and height
    @block_size = 50
    @blocks = []
    @width_in_blocks = @width/@block_size
    @last_line = 0
    @prng = Random.new
    @player = Player.new(@width_in_blocks/2*@block_size, 5.1*@block_size, @game)
    5.times { |_| generate_row }
  end

  def generate_row
    y = @last_line
    last = @width_in_blocks - 1
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    y += @block_size
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    hole = @prng.rand(0...@width_in_blocks-3)
    (0...@width_in_blocks-2).select { |i| i<hole || i> hole+1}.each { |i| @blocks << Block.new((i+1)*@block_size, y) }
    y += @block_size
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    @last_line = y + @block_size
  end

  def draw
    @player.draw
    @blocks.each { |e| e.draw }
  end

  def update_delta(delta, rolled)
    if @last_line < (@height + 4*@block_size)
      generate_row
      @blocks.select! { |e| e.y >= -1 * @block_size }
    end
    @last_line -= rolled
    @player.update_delta(delta, rolled, @blocks)
    @blocks.each { |e| e.update_delta(delta, rolled) }

  end
end
