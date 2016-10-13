desc 'Test with a simple template'
task :templatetest do
  require_relative 'lib/rodolfo'
  template_path = File.join(__dir__, 'templates', 'simple')
  bytes = Rodolfo::Pdf.new(template_path).make msg: 'Hello World'
  open('templatetest.pdf', 'wb') { |f| f.puts bytes }
end

task default: [:templatetest]
