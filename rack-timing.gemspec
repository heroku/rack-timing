# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'timing/version'

Gem::Specification.new do |spec|
  spec.name          = "rack-timing"
  spec.version       = Rack::Timing::VERSION
  spec.authors       = ["Chad Bailey"]
  spec.email         = ["chad@heroku.com"]
  spec.description   = %q{Analyze timing and process info from your Rack stack.}
  spec.summary       = %q{Analyze timing and process info from your Rack stack.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
