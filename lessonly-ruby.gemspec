# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'English'
require 'lessonly/version'

Gem::Specification.new do |spec|
  spec.name          = 'lessonly-ruby'
  spec.version       = Lessonly::VERSION
  spec.authors       = ['Skylar Anderson']
  spec.email         = ['skylar@aptible.com']
  spec.description   = 'Ruby client for Lesson.ly API'
  spec.summary       = 'Ruby client for Lesson.ly API'
  spec.homepage      = 'https://github.com/aptible/lessonly-ruby'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($RS)
  spec.test_files    = spec.files.grep(/^spec\//)
  spec.require_paths = ['lib']

  spec.add_dependency 'gem_config'
  spec.add_dependency 'sawyer', '~> 0.5.3'
  spec.add_dependency 'pry'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'aptible-tasks'
  spec.add_development_dependency 'rake'
end
