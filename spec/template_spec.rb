require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
require File.join(root_path, 'packages', 'simple', 'template')

describe Rodolfo::Template do
  subject(:template) { Rodolfo::Template.new({}) }

  it 'returns a json schema' do
    expect(template).to respond_to(:to_proc)
  end

end
