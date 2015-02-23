# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'torobot/version'

Gem::Specification.new do |spec|
  spec.name          = "torobot"
  spec.version       = Torobot::VERSION
  spec.authors       = ["Tamas Drahos"]
  spec.email         = ["drahostamas@gmail.com"]
  spec.summary       = %q{Adapter for torobot 32 channel servo controller}
  spec.description   = %q{Adapter for torobot 32 channel servo controller}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
end
