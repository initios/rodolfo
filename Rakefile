require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

Cucumber::Rake::Task.new(:features) { |t| t.cucumber_opts = 'features --format pretty' }
RSpec::Core::RakeTask.new :spec
RuboCop::RakeTask.new

task default: [:spec, :rubocop]

desc 'Update cucumber docs'
Cucumber::Rake::Task.new(:docs) do |t|
  t.cucumber_opts = '--format html -o docs/features.html'
end

# CI
Cucumber::Rake::Task.new(:cifeatures) do |t|
  t.cucumber_opts = '-f junit --out build/logs'
end

RSpec::Core::RakeTask.new(:cispec) do |t|
  t.fail_on_error = false
  t.rspec_opts = '--no-drb -r rspec_junit_formatter --format RspecJunitFormatter -o build/logs/rspec.xml'
end

task ci: [:cispec, :cifeatures]
