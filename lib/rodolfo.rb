require 'pathname'
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'

module Rodolfo
  VERSION = '0.0.3'.freeze

  class Package
    def initialize(path)
      @path = Pathname.new(path).absolute? ? path : File.join(Dir.pwd, path)
      @json_file_path = File.join @path, 'schema.json'
      @template_file_path = File.join @path, 'template'
    end

    def schema
      @json_schema ||= File.read @json_file_path
    end

    def make(data)
      require @template_file_path
      p = Rodolfo::Template.new data
      Prawn::Document.new(&p).render
    end
  end
end
