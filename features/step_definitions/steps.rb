# current_path = File.expand_path File.dirname(__FILE__)
# root_path = File.dirname(File.dirname(current_path))

# valid_json_file = File.join(root_path, 'example.json')

# When(/^I pipe in valid json data$/) do
#   json_data = File.read(valid_json_file)
#   type(json_data)
#   close_input
# end

# Then(/^the stdout should contain the generated pdf contents$/) do
#   pdf_content = all_stdout
#   @text_analysis = PDF::Inspector::Text.analyze(pdf_content)
#   @page_analysis = PDF::Inspector::Page.analyze(pdf_content)
# end

# Then(/^the pdf should contain:$/) do |table|
#   table.raw.each do |value|
#     expect(@text_analysis.strings.join(' ')).to include(value.first)
#   end
# end

# Then(/^the pdf should contain (\d+) pages$/) do |amount|
#   expect(@page_analysis.pages.size).to eq amount.to_i
# end

Then(/^the output should contain the current Rodolfo version$/) do
  output = all_commands.map(&:stdout).join('\n')
  expect(output).to eql Rodolfo::VERSION
end
