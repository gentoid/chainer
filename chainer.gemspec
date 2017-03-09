# frozen_string_literal: true

require_relative 'lib/chainer/version'
require 'date'

Gem::Specification.new do |s|
  s.name        = 'chainer'
  s.version     = ::Chainer::VERSION
  s.date        = Date.today.to_s
  s.summary     = 'Allows to pipe Ruby calls in a nice way'
  s.description = 'Allows to pipe Ruby calls in a nice way'
  s.authors     = ['Viktor Lazarev']
  s.email       = 'taurus101v@gmail.com'
  s.files       = `git ls-files lib`.split("\n")
  s.homepage    = 'https://github.com/gentoid/chainer'
  s.license     = 'MIT'

  s.add_development_dependency 'rubocop', '~> 0.47'
  s.add_development_dependency 'rubocop-rspec', '~> 1.12'
  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'yard', '~> 0.9.8'
  s.add_development_dependency 'pry', '~> 0.10.0'
end
