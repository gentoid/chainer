require_relative 'lib/chainer/version'

Gem::Specification.new do |s|
  s.name        = 'chainer'
  s.version     = ::Chainer::VERSION
  s.date        = '2017-03-01'
  s.summary     = "Allows to pipe Ruby calls in a nice way"
  s.description = "Allows to pipe Ruby calls in a nice way"
  s.authors     = ["Viktor Lazarev"]
  s.email       = 'taurus101v@gmail.com'
  s.files       = []
  s.homepage    = 'https://github.com/gentoid/chainer'
  s.license     = 'MIT'

  s.add_development_dependency 'rubocop', '~> 0.47'
  s.add_development_dependency 'rspec', '~> 3.5'
end
