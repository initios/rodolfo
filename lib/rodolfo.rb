require 'prawn'
# require 'prawn/measurements'
# require 'prawn/measurement_extensions'
# require 'prawn/table'

module Rodolfo
  class Template
    def initialize(path)
      @path = path
      @json_file_path = File.join @path, 'schema.json'
      @template_file_path = File.join @path, 'schema.json'
    end

    def schema
      @json_schema ||= File.read @json_file_path
    end
  end
end
