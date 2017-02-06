require 'gosu'
require 'racer/tower'

module Racer
  class Game < Gosu::Window
    def initialize
        super(1200, 800, true)
        self.caption = 'MI-RUB'

        @font = Gosu::Font.new(self, 'Arial', 30)
        @font2 = Gosu::Font.new(self, 'Arial', 300)
        @big_font = Gosu::Font.new(self, 'Arial', 280)

        @base_path = File.expand_path('../..', __FILE__) + '/'
        @background = Gosu::Image.new(self, @base_path + '/media/bg.png')
        @bomb_img = Gosu::Image.new(self, @base_path + 'media/power_ups/bomb2.png')
        @ruby_img = Gosu::Image.new(self, @base_path +  'media/power_ups/ruby.png')
        @pause_img = Gosu::Image.new(self, @base_path +  'media/power_ups/pause.png')
        @bg_scale_x = (1.0 * self.width) / @background.width
        @bg_scale_y = (1.0 * self.height) / @background.height

        @theme_sound = Gosu::Song.new(@base_path + 'media/music/theme.ogg')
        @bomb_sound = Gosu::Sample.new(@base_path + 'media/music/bomb.ogg')
        @coin_sound = Gosu::Sample.new(@base_path + 'media/music/coin.ogg')
        @gameover_sound = Gosu::Song.new(@base_path + 'media/music/gameover.ogg')

        @last_milliseconds = 0
        @detonation_end = 0
        @pause_end = 3
        @subliminal_start = 0
        @subliminal = false

        @tower = Tower.new(self)
        @components = [@tower].flatten

        @basic_rolling_speed = 50
        @rolling_speed = @basic_rolling_speed
        @rolling_increment = 2
        @rolling_limit = 125

        @bombs = 3
        @coins = 0
        @rubies = 3
        @pauses = 3

        @score = 0
        @state = :active
        @theme_sound.play(true)

        @paused = true
    end

    def draw
      @background.draw(0, 0, 0, @bg_scale_x, @bg_scale_y)
      @tower.draw
      if @state == :active
        Gosu.draw_rect(0, 0, self.width, @font.height + 20, 0x80_ffffff, z = 2)
        @font.draw("Score: #{@score.round}", 10, 10, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        rubies = "F: #{@rubies}x"
        pauses = "S: #{@pauses}x"
        bombs = "D: #{@bombs}x"
        @font.draw(rubies, 6*self.width/9, 10, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        @font.draw(pauses, 7*self.width/9, 10, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        @font.draw(bombs, 8*self.width/9, 10, 2, 1.0, 1.0, Gosu::Color::YELLOW)
        @ruby_img.draw(6*self.width/9 + @font.text_width(rubies) + 5, 9, 2, 0.03, 0.03)
        @pause_img.draw(7*self.width/9 + @font.text_width(pauses) + 5, 9, 2, 0.45, 0.45)
        @bomb_img.draw(8*self.width/9 + @font.text_width(bombs) + 5, 9, 2, 0.04, 0.04)
      else
        text = "Score: #{@score.round}"
        width = @font2.text_width(text)
        height = @font2.height
        scale_x = width > 1200 ? 1100.0/width : 1
        width *= scale_x
        @font2.draw(text, 600 - width/2, 400 - height/2, 2, scale_x, 1, Gosu::Color::YELLOW)
      end
      if @subliminal
        @subliminal = false if @subliminal_start + 0.05 < @last_milliseconds
        width = @big_font.text_width("A")*5
        height = @big_font.height*5
        @big_font.draw("A", 600-width/2, 525-height/2 , 2, 5, 5, 0x80_ffffff)
      end
    end

    def button_up(key)
        self.close if key == Gosu::KbEscape
        self.bomb_detonate if key == Gosu::KbD && @bombs > 0 && @detonation_end < @last_milliseconds
        self.stop_time if key == Gosu::KbS && @pauses > 0 && @pause_end < @last_milliseconds
        self.flash if key == Gosu::KbF && @rubies > 0
        @paused = false if key == Gosu::KbO
        @paused = true if key == Gosu::KbP
    end

    def update
        self.update_delta
    end

    def update_delta
      unless @paused
        @theme_sound.play(true) unless Gosu::Song.current_song

        current_time = Gosu::milliseconds / 1000.0
        @delta = [current_time - @last_milliseconds, 0.10].min
        @last_milliseconds = current_time
        rolled = 0

        if current_time > @pause_end
          rolled = @rolling_speed*@delta
          @score += rolled if @state == :active
          @rolling_speed += @delta*@rolling_increment if @rolling_speed < @rolling_limit
        end
        @components.each { |c| c.update_delta(@delta, rolled) }
      end
    end

    def add_pause
      @pauses += 1
      @coin_sound.play
    end

    def add_bomb
      @bombs += 1
      @coin_sound.play
    end

    def add_coin
      @coins += 1
      @score += 10*@rolling_limit
      @coin_sound.play
    end

    def add_ruby
      @rubies += 1
      @subliminal_start = @last_milliseconds
      @subliminal = true
      @coin_sound.play
    end

    def stop_time
      @pause_end = @last_milliseconds + 4
      @pauses -= 1
    end

    def bomb_detonate
      @detonation_end = @last_milliseconds + 0.5
      @bombs -= 1
      @bomb_sound.play
      @tower.detonation(75)
    end

    def flash
      @pause_end = (@pause_end > @last_milliseconds ? @pause_end : @last_milliseconds) + 0.5
      @subliminal_start = @last_milliseconds
      @subliminal = true
      @rubies -= 1
      @tower.flash
      @rolling_speed = @basic_rolling_speed
    end

    def out_of_screen
      if @rubies > 0
        self.flash
      else
        @state = :over
        @gameover_sound.play(true)
      end
    end
  end
end
