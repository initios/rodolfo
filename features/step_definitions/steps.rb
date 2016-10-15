Then(/^the stdout should contain the current Rodolfo version$/) do
  step %(the output should contain "#{Rodolfo::VERSION}")
end

Then(/^the file named "([^"]*)" should exist and be a valid pdf$/) do |name|
  step %(a file named "#{name}" should exist)

  file_path = File.join aruba.config.working_directory, name
  pdf_content = File.read file_path
  @text_analysis = PDF::Inspector::Text.analyze(pdf_content)
  @page_analysis = PDF::Inspector::Page.analyze(pdf_content)
end

Then(/^the pdf should include:$/) do |table|
  table.raw.each do |value|
    expect(@text_analysis.strings.join(' ')).to include(value.first)
  end
end

Then(/^the pdf should contain (\d+) pages?$/) do |amount|
  expect(@page_analysis.pages.size).to eq amount.to_i
end
