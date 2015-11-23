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
  s.description   = %q{TODO: Write a longer description or delete this line.}
  s.homepage      = "TODO: Put your gem's website or public repo URL here."
  s.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if s.respond_to?(:metadata)
    s.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|s|features)/}) }
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency 'rack'
  s.add_development_dependency 'thin', '>= 1.2.0'
  s.add_development_dependency "rspec"
  s.add_dependency "faye-websocket", "~> 0.9.2"
end
