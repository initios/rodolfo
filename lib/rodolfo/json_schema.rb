require 'json'
require 'json-schema'
require_relative 'exceptions'

# Create PDFs from the CLI using Prawn
module Rodolfo
  # Rodolfo Recipe JSON Schema
  class JSONSchema
    def initialize(path, strict = false)
      @path = path
      @strict = strict
    end

    # Validate the json schema
    # May raise a SchemaValidationError
    def validate(data)
      opts = { insert_defaults: true, strict: @strict }
      errors = JSON::Validator.fully_validate json, data, opts
      raise SchemaValidationError, errors unless errors.empty?
      data
    end

    def to_h
      JSON.parse json
    end

    def json
      @json ||= File.read @path
    end

    def to_s
      json
    end
  end
end
