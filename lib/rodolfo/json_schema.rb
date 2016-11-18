require 'json'
require 'json-schema'
require_relative 'exceptions'

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
      raise SchemaValidationError, errors unless errors.empty?
    end

    def json
      @json ||= File.read @path
    end

    def to_s
      json
    end
  end
end
