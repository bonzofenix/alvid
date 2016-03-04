# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'alvid/version'

Gem::Specification.new do |s|
  s.name          = "alvid"
  s.version       = Alvid::VERSION
  s.authors       = ["Alan Moran", "David Brock"]
  s.email         = ["bonzofenix@gmail.com", "dbrockjr@gmail.com"]

  s.summary       = %q{Alvid is an advanced AI bot that integrates with slack.}
  s.homepage      = "http://bonzofenix.github.io/alvid"
  s.license       = "MIT"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|s|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency 'rack'
  s.add_development_dependency 'thin', '>= 1.2.0'
  s.add_development_dependency "rspec"
  s.add_development_dependency "byebug"
  s.add_development_dependency "factory_girl"
  s.add_dependency "dm-sqlite-adapter"
  s.add_dependency "dm-mysql-adapter"
  s.add_dependency "data_mapper"
  s.add_dependency "octokit"
  s.add_dependency "sshkey"
end
