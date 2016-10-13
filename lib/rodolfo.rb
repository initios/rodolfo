require 'prawn'
# require 'prawn/measurements'
# require 'prawn/measurement_extensions'
# require 'prawn/table'

module Rodolfo
  class TemplatePackage
    def initialize(path)
      @path = path
      @json_file_path = File.join @path, 'schema.json'
      @template_file_path = File.join @path, 'template.rb'
    end

    def schema
      @json_schema ||= File.read @json_file_path
    end

    def proc_maker(data)
      require @template_file_path
      Rodolfo.make_proc data
    end
  end
end
