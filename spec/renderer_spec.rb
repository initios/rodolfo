require 'rodolfo/renderer'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
example_template_path = File.join root_path, 'recipes', 'example'

require File.join(root_path, 'recipes', 'example', 'template')

describe Rodolfo::Renderer do
  subject(:renderer) { Rodolfo::Renderer.new example_template_path, {} }

  it 'returns a json schema' do
    schema = renderer.json_schema
    expect(schema).to include_json(description: 'Example Template')
  end

  it 'adds default values for fields that are not present' do
    expect(renderer.validated_data['msg']).to eq('default msg')
  end
end
