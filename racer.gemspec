# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'racer/version'

Gem::Specification.new do |spec|
  spec.name          = "racer"
  spec.version       = Racer::VERSION
  spec.authors       = ["Miroslav Brabenec"]
  spec.email         = ["brabemi3@fit.cvut.cz"]

  spec.summary       = %q{2D game platformer game}
  spec.description   = %q{2D game platformer game}
  spec.homepage      = "https://gitlab.fit.cvut.cz/brabemi3/MI-RUB-racer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.glob("{bin,lib,media}/**/*") + %w(Gemfile LICENSE.txt Rakefile README.md)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "gosu", "~> 0.10.8"
end