#!/bin/ruby
# -*- encoding : utf-8 -*-
require_relative 'spec_helper'
require_relative '../lib/racer/flash'
require_relative '../lib/racer/explosion'

describe Flash do
  subject(:flash) { Flash.new(100, 100) }

  describe 'expected eroperties' do
    it do
      expect(flash.x).to eq 100
      expect(flash.y).to eq 100
      expect(flash.height).to be > 50
      expect(flash.height).to be < 500
      expect(flash.width).to be > 50
      expect(flash.width).to be < 500
    end
  end

  describe 'rolling' do
    it do
      expect(flash.x).to eq 100
      expect(flash.y).to eq 100
      flash.update_delta(0, 20)
      expect(flash.x).to eq 100
      expect(flash.y).to eq 80
    end
  end

  describe 'no falling' do
    it do
      expect(flash.x).to eq 100
      expect(flash.y).to eq 100
      flash.update_delta(10, 0)
      expect(flash.x).to eq 100
      expect(flash.y).to eq 100
    end
  end
end

describe Explosion do
  subject(:explosion) { Explosion.new(100, 100) }

  describe 'expected eroperties' do
    it do
      expect(explosion.x).to eq 100
      expect(explosion.y).to eq 100
      expect(explosion.height).to be > 50
      expect(explosion.height).to be < 500
      expect(explosion.width).to be > 50
      expect(explosion.width).to be < 500
    end
  end

  describe 'rolling' do
    it do
      expect(explosion.x).to eq 100
      expect(explosion.y).to eq 100
      explosion.update_delta(0, 20)
      expect(explosion.x).to eq 100
      expect(explosion.y).to eq 80
    end
  end

  describe 'no falling' do
    it do
      expect(explosion.x).to eq 100
      expect(explosion.y).to eq 100
      explosion.update_delta(10, 0)
      expect(explosion.x).to eq 100
      expect(explosion.y).to eq 100
    end
  end
end
