require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
simple_template_path = File.join root_path, 'packages', 'simple'

require File.join(root_path, 'packages', 'simple', 'template')

describe Rodolfo::Package do
  subject(:package) { Rodolfo::Package.new simple_template_path }

  context 'when template package is correct' do
    it 'returns a json schema' do
      expect(package.schema).to include_json(description: 'Simple Template')
    end

    it 'returns its Template class' do
      expect(package.template).to be Rodolfo::Template
    end
  end
end
