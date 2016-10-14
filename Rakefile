require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: [:spec, :rubocop]

# CI
RSpec::Core::RakeTask.new(:cispec) do |t|
  t.fail_on_error = false
  t.rspec_opts = '--no-drb -r rspec_junit_formatter --format RspecJunitFormatter -o build/logs/rspec.xml'
end

task ci: [:cispec]
