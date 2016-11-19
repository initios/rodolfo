require 'pathname'
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'

require_relative 'json_schema'
require_relative 'exceptions.rb'

# Create PDFs from the CLI using Prawn
module Rodolfo
  ##
  # Requires a filesystem folder path which should contain
  # - schema.json to perform the validation
  # - data.json as example data (for testing purposes only and valid example)
  # - template.rb the pdf generator itself
  #
  # It renders the the given template validating
  # the data against that json schema
  class Renderer
    attr_reader :data, :validation_errors

    def initialize(path, data)
      @path = Pathname.new(path).absolute? ? path : File.join(Dir.pwd, path)
      @data = data
      @schema = JSONSchema.new File.join(@path, 'schema.json')
    end

    # Get the package json schema
    def json_schema
      @schema.to_s
    end

    # Validates the data against the json schema
    def validated_data
      @schema.validate(@data)
    end

    def pdf_meta
      schema_meta = @schema.to_h

      { CreationDate: Time.now.iso8601,
        Renderer: "Rodolfo v#{VERSION}",
        JsonSchema: {
          description: schema_meta['description'],
          id: schema_meta['id'],
          schema: schema_meta['$schema']
        } }
    end

    # Render the template
    def render
      require File.join @path, 'template'
      t = Rodolfo::Template.new(validated_data)
      Prawn::Document.new(info: pdf_meta, **t.config, &t).render
    rescue NoMethodError
      msg = 'Missing or incorrect data, template can\'t be rendered'
      raise RenderError, [msg]
    end
  end
end
