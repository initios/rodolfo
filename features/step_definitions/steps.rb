Then(/^the stdout should contain the current Rodolfo version$/) do
  step %(the output should contain "#{Rodolfo::VERSION}")
end

Then(/^the file named "([^"]*)" should exist and be a valid pdf$/) do |name|
  step %(a file named "#{name}" should exist)

  file_path = File.join aruba.config.working_directory, name
  @reader = PDF::Reader.new file_path
end

Then(/^the pdf should include:$/) do |table|
  table.raw.each do |value|
    expect(@reader.pages.first.text).to include(value.first)
  end
end

Then(/^the pdf should contain (\d+) pages?$/) do |amount|
  expect(@reader.page_count).to eq amount.to_i
end

Then(/^the stdout should contain the generated pdf contents$/) do
  pdf_content = all_commands.map(&:stdout).join("\n")
  f = StringIO.new
  f.write pdf_content
  @reader = PDF::Reader.new f
end

Then(/^the pdf should contain metadata$/) do
  schema = {
    description: 'Example Template',
    id: 'http://www.example.com/json-schema/v2/tpl/example-template',
    schema: 'http://json-schema.org/draft-04/schema#'
  }
  expect(@reader.info).to include(:CreationDate)
  expect(@reader.info).to include(:Renderer)
  expect(@reader.info).to include(JsonSchema: schema)
end

Given(/^a file example\.pdf$/) do
  features_path = File.dirname(__dir__)
  root_path = File.dirname(features_path)
  filename = File.join(root_path, 'recipes', 'example', 'example.pdf')
  dest_folder = aruba.config.working_directory
  FileUtils.cp(filename, aruba.config.working_directory)
end
