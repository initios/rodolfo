require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
simple_template_path = File.join root_path, 'templates', 'simple'

require File.join(root_path, 'templates', 'simple', 'template')

RSpec.describe Rodolfo::TemplatePackage do
  subject(:package) { Rodolfo::TemplatePackage.new simple_template_path }

  context 'when template package is correct' do
    it 'returns a json schema' do
      expect(package.schema).to include_json(description: 'Simple Template')
    end

    it 'returns a proc maker function' do
      expect(package.proc_maker(msg: 'Hello')).to be_an_instance_of Proc
    end
  end
end
