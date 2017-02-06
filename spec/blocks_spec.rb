#!/bin/ruby
# -*- encoding : utf-8 -*-
require_relative 'spec_helper'
require_relative '../lib/racer/wood_block'
require_relative '../lib/racer/moss_block'
require_relative '../lib/racer/brick_block'

describe WoodBlock do
  subject(:block) { WoodBlock.new(100, 100, true) }
  subject(:i_block) { WoodBlock.new(100, 100, false) }

  describe 'expected eroperties' do
    it do
      expect(block.x).to eq 100
      expect(block.y).to eq 100
      expect(block.height).to eq 50
      expect(block.width).to eq 50
      expect(block.speed_modif).to eq 1
      expect(block.destructible).to be true
      expect(i_block.destructible).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(0, 20)
      expect(block.y).to eq 80
      expect(block.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(10, 0)
      expect(block.y).to eq 100
      expect(block.x).to eq 100
    end
  end
end

describe MossBlock do
  subject(:block) { MossBlock.new(100, 100, true) }
  subject(:i_block) { MossBlock.new(100, 100, false) }

  describe 'expected eroperties' do
    it do
      expect(block.x).to eq 100
      expect(block.y).to eq 100
      expect(block.height).to eq 50
      expect(block.width).to eq 50
      expect(block.speed_modif).to be < 1
      expect(block.destructible).to be true
      expect(i_block.destructible).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(0, 20)
      expect(block.y).to eq 80
      expect(block.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(10, 0)
      expect(block.y).to eq 100
      expect(block.x).to eq 100
    end
  end
end

describe BrickBlock do
  subject(:block) { BrickBlock.new(100, 100, true) }
  subject(:i_block) { BrickBlock.new(100, 100, false) }

  describe 'expected eroperties' do
    it do
      expect(block.x).to eq 100
      expect(block.y).to eq 100
      expect(block.height).to eq 50
      expect(block.width).to eq 50
      expect(block.speed_modif).to be > 1
      expect(block.destructible).to be false
      expect(i_block.destructible).to be false
    end
  end

  describe 'rolling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(0, 20)
      expect(block.y).to eq 80
      expect(block.x).to eq 100
    end
  end

  describe 'no falling' do
    it do
      expect(block.y).to eq 100
      expect(block.x).to eq 100
      block.update_delta(10, 0)
      expect(block.y).to eq 100
      expect(block.x).to eq 100
    end
  end
end
