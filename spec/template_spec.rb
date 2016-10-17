require 'rodolfo'
require 'rspec/json_expectations'

root_path = File.dirname __dir__
require File.join(root_path, 'packages', 'example', 'template')

describe Rodolfo::Template do
  subject(:template) { Rodolfo::Template.new({}) }

  it 'acts like a proc' do
    expect(template).to be_a_kind_of Prawn::Document
  end
end
