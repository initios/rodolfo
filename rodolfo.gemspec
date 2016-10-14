$LOAD_PATH.unshift './lib'
require 'rodolfo'

Gem::Specification.new do |s|
  s.name        = 'rodolfo'
  s.version     = Rodolfo::VERSION
  s.date        = '2016-10-14'
  s.summary     = 'rodolfo'
  s.description = 'Create pdfs with Prawn'
  s.authors     = ['Initios']
  s.email       = 'dev@initios.com'
  s.files       = Dir['lib/**/*']
  s.executables << 'rodolfo'
  s.homepage    = 'https://github.com/initios/rodolfo'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.0'
end
