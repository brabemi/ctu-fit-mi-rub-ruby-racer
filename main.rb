# require 'rubygems'
require 'gosu'
require_relative './player'
require_relative './tower'

class Game < Gosu::Window
    def initialize
        super(1200, 800, false)
        self.caption = 'MI-RUB'

        # @background = Gosu::Image.new(self, 'media/bg.png')

        @last_milliseconds = 0

        @tower = Tower.new(self)
        @components = [@tower].flatten
        @rolling_speed = 50
        @rolling_increment = 1
    end

    def draw
      @components.each { |c| c.draw }
      @tower.draw
      # @background.draw(0, 0, 0)
    end

    # this is a callback for key up events or equivalent (there are
    # constants for gamepad buttons and mouse clicks)
    def button_up(key)
        self.close if key == Gosu::KbEscape
    end


    def update
        self.update_delta
        # with a delta we need to express the speed of our entities in
        # terms of pixels/second
    end

    def update_delta
        # Gosu::millisecodns returns the time since the window was created
        # Divide by 1000 since we want to work in seconds
        current_time = Gosu::milliseconds / 1000.0
        # clamping here is important to avoid strange behaviors
        @delta = [current_time - @last_milliseconds, 0.25].min
        @last_milliseconds = current_time
        @components.each { |c| c.update_delta(@delta, @rolling_speed*@delta) }
        @rolling_speed += @delta*@rolling_increment if @rolling_speed < 150
    end
end

game = Game.new
game.show
