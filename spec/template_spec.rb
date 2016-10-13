require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
simple_template = File.join root_path, 'templates', 'simple'

RSpec.describe Rodolfo::Template do
  before { @template = Rodolfo::Template.new simple_template }

  it('returns its json schema') do
    expect(@template.schema).to include_json(description: 'Simple Template')
  end
end
