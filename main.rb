# require 'rubygems'
require 'gosu'
require_relative './tower'

class Game < Gosu::Window
    def initialize
        super(1200, 800, false)
        self.caption = 'MI-RUB'

        # @background = Gosu::Image.new(self, 'media/bg.png')

        @last_milliseconds = 0
        @pause_end = 0

        @tower = Tower.new(self)
        @components = [@tower].flatten
        @rolling_speed = 50
        @rolling_increment = 2
        @rolling_limit = 150
        @bombs = 0
        @coins = 0
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
        rolled = 0
        if current_time > @pause_end
          rolled = @rolling_speed*@delta
          @rolling_speed += @delta*@rolling_increment if @rolling_speed < @rolling_limit
        end
        @components.each { |c| c.update_delta(@delta, rolled) }
    end

    def stop_time(pause_length)
      @pause_end = pause_length + Gosu::milliseconds / 1000.0
    end

    def add_bomb()
      @bombs += 1
      p "#{@bombs} bombs"
    end

    def add_coin()
      @coins += 1
      p "#{@coins} coins"
    end
end

game = Game.new
game.show
