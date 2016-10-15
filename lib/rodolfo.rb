module Rodolfo
  VERSION = '0.0.2'.freeze

  class Pdf
    def initialize(path)
      @package = TemplatePackage.new path
    end

    def schema
      @package.schema
    end

    def make(data)
      require 'prawn'
      require 'prawn/measurements'
      require 'prawn/measurement_extensions'
      require 'prawn/table'

      p = @package.proc_maker(data)
      Prawn::Document.new(&p).render
    end
  end

  class Package
    def initialize(path)
      @path = path
      @json_file_path = File.join @path, 'schema.json'
      @template_file_path = File.join @path, 'template.rb'
    end

    def schema
      @json_schema ||= File.read @json_file_path
    end

    def template
      unless @template
        require @template_file_path
        @template = Template
      end

      @template
    end
  end
end
