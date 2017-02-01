require_relative './block'

class Tower
  def initialize(width, heigh)
    @width = width
    @heigh = heigh
    @block_size = 75
    @blocks = []
    @width_in_blocks = @width/@block_size
    @last_line = 0
    3.times { |_| generate_row }
  end

  def generate_row()
    y = @last_line
    last = @width_in_blocks - 1
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    y += @block_size
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    (@width_in_blocks-2).times { |i| @blocks << Block.new((i+1)*@block_size, y) }
    y += @block_size
    @blocks << Block.new(0, y, false) << Block.new(last*@block_size, y, false)
    @last_line = y + @block_size
  end

  def draw
    @blocks.each { |e| e.draw }
  end

  def update_delta(delta, rolled)
    @last_line -= rolled
    if @last_line <= 800
      generate_row
      @blocks.select! { |e| e.y >= -1 * @block_size }
    end
    @blocks.each { |e| e.update_delta(delta, rolled) }
  end
end
