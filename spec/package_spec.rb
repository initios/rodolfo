require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
example_template_path = File.join root_path, 'packages', 'example'

require File.join(root_path, 'packages', 'example', 'template')

describe Rodolfo::Package do
  subject(:package) { Rodolfo::Package.new example_template_path }

  context 'when template package is correct' do
    it 'returns a json schema' do
      expect(package.schema).to include_json(description: 'Example Template')
    end
  end
end
