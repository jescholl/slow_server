# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slow_server/version'

Gem::Specification.new do |spec|
  spec.name          = "slow_server"
  spec.version       = SlowServer::VERSION
  spec.authors       = ["Jason Scholl"]
  spec.email         = ["jason.e.scholl@gmail.com"]

  spec.summary       = %q{Simple slow web server and client }
  spec.description   = %q{Simple web server and client with adjustable delays for testing timeouts on clients, servers and proxy servers}
  spec.homepage      = "https://github.com/jescholl/slow_server"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "codeclimate-test-reporter"
end
