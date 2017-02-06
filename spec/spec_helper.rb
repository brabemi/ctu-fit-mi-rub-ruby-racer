#!/usr/bin/env ruby
require 'bundler/setup'
Bundler.setup

require 'racer'

RSpec.configure do |c|
  c.color = true
  c.formatter = :documentation
  c.tty = true
end
