# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brandmaker/version'

Gem::Specification.new do |gem|
  gem.name          = "brandmaker"
  gem.version       = Brandmaker::VERSION
  gem.authors       = ["Sebastian de Castelberg"]
  gem.email         = ["sebu@kpricorn.org"]
  gem.description   = %q{Allows access to BrandMaker JobManager (DSE) and MediaPool APIs}
  gem.summary       = %q{Ruby based BrandMaker API}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'savon', '~> 1.2.0'
  gem.add_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'pry'
end
