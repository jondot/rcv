# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rcv/version'

Gem::Specification.new do |spec|
  spec.name          = "vcr-rcv"
  spec.version       = RCV::VERSION
  spec.authors       = ["Dotan Nahum"]
  spec.email         = ["jondotan@gmail.com"]
  spec.summary       = %q{VCR in reverse. Use RCV to do consumer driven contract testing with your existing VCR tests}
  spec.description   = %q{VCR in reverse. Use RCV to do consumer driven contract testing with your existing VCR tests}
  spec.homepage      = "https://github.com/jondot/rcv"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['reverse_play_cassette']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "rest-client", "~> 2.0.0.rc2"
  spec.add_runtime_dependency "minitest", "~> 5.8.4"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 0.8"
  spec.add_development_dependency "rspec", "~> 2.6"
end
