#!/bin/ruby
# -*- encoding : utf-8 -*-
require 'ostruct'

require_relative 'spec_helper'
require_relative '../lib/racer/player'

describe Player do
  subject(:fake_game) { OpenStruct.new(height: 1000) }
  subject(:player) { Player.new(100, 100, fake_game) }
  subject(:small_block) do
    OpenStruct.new(height: player.height/2, width: player.width/2,
      x: 100, y: 200 + player.height, speed_modif: 1)
  end
  subject(:block) do
    OpenStruct.new(height: 2*player.height , width: 2*player.width,
      x: 120, y: 200 + player.height, speed_modif: 1)
  end
  subject(:block2) do
     OpenStruct.new(height: 100, width: 200, x: 200 + player.width, y: 200 + player.height)
  end

  describe 'x position' do
    it { expect(player.x).to eq 100 }
  end

  describe 'y position' do
    it { expect(player.y).to eq 100 }
  end

  describe 'reasonable size' do
    it do
      expect(player.height).to be > 40
      expect(player.height).to be < 400
      expect(player.width).to be > 30
      expect(player.width).to be < 300
    end
  end

  describe 'rolling' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      player.update_delta(0, 20, [])
      expect(player.y).to eq 80
      expect(player.x).to eq 100
    end
  end

  describe 'falling' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      player.update_delta(1e-8, 0, [])
      expect(player.y).to be > 100
      expect(player.x).to eq 100
    end
  end

  describe 'falling on block' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      loop do
        y_old = player.y
        player.update_delta(0.03, 0, [block])
        break if player.y <= y_old
      end
      expect(player.y + player.height).to be <= block.y
      expect(player.x).to eq 100
    end
  end

  describe 'falling on small block' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      loop do
        y_old = player.y
        player.update_delta(0.03, 0, [small_block])
        break if player.y <= y_old
      end
      expect(player.y + player.height).to be <= small_block.y
      expect(player.x).to eq 100
    end
  end

  describe 'falling on block with big delta' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      loop do
        y_old = player.y
        player.update_delta(60, 0, [small_block])
        break if player.y <= y_old
      end
      expect(player.y + player.height).to be <= small_block.y
      expect(player.x).to eq 100
    end
  end

  describe 'falling out of block' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      loop do
        player.update_delta(0.03, 0, [block2])
        break if player.y > block2.y + block2.width
      end
      expect(player.y).to be > block2.y + block2.width
      expect(player.x).to eq 100
    end
  end

  describe 'flash' do
    it do
      expect(player.y).to eq 100
      expect(player.x).to eq 100
      player.flash(20, 20)
      expect(player.y).to eq 20
      expect(player.x).to eq 20
    end
  end
end
