require 'json'
require 'json-schema'
require 'pathname'
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'
require_relative 'exceptions.rb'

# Create PDFs from the CLI using Prawn
module Rodolfo

  # Rodolfo Package JSON Schema
  class JSONSchema
    def initialize(path)
      @path = path
    end

    # Validate the json schema
    # May raise a SchemaValidationError
    def validate(data)
      opts = { errors_as_objects: true, insert_defaults: true,
               strict: true }
      errors = JSON::Validator.fully_validate json, data, opts
      raise SchemaValidationError(errors) unless errors.empty?
    end

    def json
      @json ||= File.read @path
    end

    def to_s
      json
    end
  end

  ##
  # Represents a filesystem folder which should contain
  # - schema.json to perform the validation
  # - data.json as example data
  # - template.rb the pdf generator itself
  #
  # It handles methods for manipulate those files and the pdf generation
  class Package
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

    # Render the template
    # May raises a ValidationError
    def render
      @schema.validate(@data)
      require File.join @path, 'template'
      Rodolfo::Template.new(@data).render

    rescue NoMethodError
      msg = 'Missing or incorrect data, template can\'t be rendered'
      raise RenderError [msg]
    end
  end
end
