#!/bin/ruby
# -*- encoding : utf-8 -*-
require 'ostruct'

require_relative 'spec_helper'
require_relative '../lib/racer/coin'
require_relative '../lib/racer/ruby'
require_relative '../lib/racer/bomb'
require_relative '../lib/racer/pause'

class FakeGame
  attr_reader :bombs, :coins, :rubies, :pauses
  def initialize
    @bombs = 0
    @coins = 0
    @rubies = 0
    @pauses = 0
  end
  def add_ruby
    @rubies+=1
  end
  def add_coin
    @coins+=1
  end
  def add_pause
    @pauses+=1
  end
  def add_bomb
    @bombs+=1
  end
end

describe Coin do
  subject(:fake_game) { FakeGame.new }
  subject(:power_up) { Coin.new(100, 100, fake_game) }
  subject(:player) { OpenStruct.new(height: 100, width: 100, x: 100, y: 100) }
  subject(:player2) { OpenStruct.new(height: 100, width: 100, x: 500, y: 500) }

  describe 'expected eroperties' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      expect(power_up.height).to be > 20
      expect(power_up.height).to be < 50
      expect(power_up.width).to be > 20
      expect(power_up.width).to be < 50
      expect(power_up.used).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(0, 20, player)
      expect(power_up.y).to eq 80
      expect(power_up.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(10, 0, player2)
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
    end
  end

  describe 'collide with player' do
    it do
      expect(fake_game.coins).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player)
      expect(fake_game.coins).to eq 1
      expect(power_up.used).to be true
    end
  end

  describe 'not collide with player' do
    it do
      expect(fake_game.coins).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player2)
      expect(fake_game.coins).to eq 0
      expect(power_up.used).to be false
    end
  end
end

describe Ruby do
  subject(:fake_game) { FakeGame.new }
  subject(:power_up) { Ruby.new(100, 100, fake_game) }
  subject(:player) { OpenStruct.new(height: 100, width: 100, x: 100, y: 100) }
  subject(:player2) { OpenStruct.new(height: 100, width: 100, x: 500, y: 500) }

  describe 'expected eroperties' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      expect(power_up.height).to be > 20
      expect(power_up.height).to be < 50
      expect(power_up.width).to be > 20
      expect(power_up.width).to be < 50
      expect(power_up.used).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(0, 20, player)
      expect(power_up.y).to eq 80
      expect(power_up.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(10, 0, player2)
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
    end
  end

  describe 'collide with player' do
    it do
      expect(fake_game.rubies).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player)
      expect(fake_game.rubies).to eq 1
      expect(power_up.used).to be true
    end
  end

  describe 'not collide with player' do
    it do
      expect(fake_game.rubies).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player2)
      expect(fake_game.rubies).to eq 0
      expect(power_up.used).to be false
    end
  end
end

describe Bomb do
  subject(:fake_game) { FakeGame.new }
  subject(:power_up) { Bomb.new(100, 100, fake_game) }
  subject(:player) { OpenStruct.new(height: 100, width: 100, x: 100, y: 100) }
  subject(:player2) { OpenStruct.new(height: 100, width: 100, x: 500, y: 500) }

  describe 'expected eroperties' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      expect(power_up.height).to be > 20
      expect(power_up.height).to be < 50
      expect(power_up.width).to be > 20
      expect(power_up.width).to be < 50
      expect(power_up.used).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(0, 20, player)
      expect(power_up.y).to eq 80
      expect(power_up.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(10, 0, player2)
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
    end
  end

  describe 'collide with player' do
    it do
      expect(fake_game.bombs).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player)
      expect(fake_game.bombs).to eq 1
      expect(power_up.used).to be true
    end
  end

  describe 'not collide with player' do
    it do
      expect(fake_game.bombs).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player2)
      expect(fake_game.bombs).to eq 0
      expect(power_up.used).to be false
    end
  end
end

describe Pause do
  subject(:fake_game) { FakeGame.new }
  subject(:power_up) { Pause.new(100, 100, fake_game) }
  subject(:player) { OpenStruct.new(height: 100, width: 100, x: 100, y: 100) }
  subject(:player2) { OpenStruct.new(height: 100, width: 100, x: 500, y: 500) }

  describe 'expected eroperties' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      expect(power_up.height).to be > 20
      expect(power_up.height).to be < 50
      expect(power_up.width).to be > 20
      expect(power_up.width).to be < 50
      expect(power_up.used).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(0, 20, player)
      expect(power_up.y).to eq 80
      expect(power_up.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
      power_up.update_delta(10, 0, player2)
      expect(power_up.x).to eq 100
      expect(power_up.y).to eq 100
    end
  end

  describe 'collide with player' do
    it do
      expect(fake_game.pauses).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player)
      expect(fake_game.pauses).to eq 1
      expect(power_up.used).to be true
    end
  end

  describe 'not collide with player' do
    it do
      expect(fake_game.pauses).to eq 0
      expect(power_up.used).to be false
      power_up.update_delta(10, 0, player2)
      expect(fake_game.pauses).to eq 0
      expect(power_up.used).to be false
    end
  end
end
