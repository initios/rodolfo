$LOAD_PATH.unshift './lib'
require 'rodolfo/meta'

Gem::Specification.new do |s|
  s.name        = 'rodolfo'
  s.version     = Rodolfo::VERSION
  s.summary     = 'rodolfo'
  s.description = 'Create pdfs with Prawn'
  s.authors     = ['Initios']
  s.email       = 'dev@initios.com'
  s.files       = Dir['lib/**/*']
  s.executables << 'rodolfo'
  s.homepage    = 'https://github.com/initios/rodolfo'
  s.license     = 'MIT'
  s.required_ruby_version = '>= 2.0'

  s.add_runtime_dependency 'json-schema', '~> 2.8.0'
  s.add_runtime_dependency 'pdf-reader', '~> 1.4.0', '>= 1.4.0'
  s.add_runtime_dependency 'prawn', '~> 2.2.0'
  s.add_runtime_dependency 'prawn-table', '~> 0.2.2'
  s.add_runtime_dependency 'thor', '~> 0.19.1'

  s.add_development_dependency 'aruba', '~> 0.14.2', '>= 0.14.2'
  s.add_development_dependency 'cucumber', '~> 2.4.0', '>= 2.4.0'
  s.add_development_dependency 'rake', '~> 11.3.0', '>= 11.3.0'
  s.add_development_dependency 'rspec', '~> 3.5', '>= 3.5'
  s.add_development_dependency 'rspec_junit_formatter', '~> 0.2.3', '>= 0.2.3'
  s.add_development_dependency 'rspec-json_expectations', '~> 1.4', '>= 1.4'
  s.add_development_dependency 'rubocop', '~> 0.43.0', '>= 0.43.0'
end
