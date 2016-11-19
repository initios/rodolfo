require 'rodolfo/reader'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
pdf_file_path = File.join(root_path, 'packages', 'example', 'example.pdf')

describe Rodolfo::Reader do
  it 'returns pdf info as json' do
    reader = Rodolfo::Reader.new pdf_file_path
    expect(reader.to_json).to include_json(Pages: 1)
  end
end
