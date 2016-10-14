require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

desc 'Test with a simple template'
task :templatetest do
  require_relative 'lib/rodolfo'
  template_path = File.join(__dir__, 'templates', 'simple')
  bytes = Rodolfo::Pdf.new(template_path).make msg: 'Hello World'
  open('templatetest.pdf', 'wb') { |f| f.puts bytes }
end

task default: [:spec, :rubocop]

# CI
RSpec::Core::RakeTask.new(:cispec) do |t|
  t.fail_on_error = false
  t.rspec_opts = '--no-drb -r rspec_junit_formatter --format RspecJunitFormatter -o build/logs/rspec.xml'
end

task ci: [:cispec, :rubocop]
