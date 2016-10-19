require 'json'
require 'json-schema'
require 'pathname'
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'

##
# Create PDFs from the CLI using Prawn
module Rodolfo
  VERSION = '0.0.5'.freeze

  ##
  # Represents a filesystem folder which should contain
  # - schema.json to perform the validation
  # - data.json as example data
  # - template.rb the pdf generator itself
  #
  # It handles methods for manipulate those files and the pdf generation
  class Package
    def initialize(path, data)
      @path = Pathname.new(path).absolute? ? path : File.join(Dir.pwd, path)
      @data = data
      @json_file_path = File.join @path, 'schema.json'
      @template_file_path = File.join @path, 'template'
    end

    def schema
      @json_schema ||= File.read @json_file_path
    end

    def valid?
      args = schema, @data, { errors_as_objects: true }
      @validation_errors = JSON::Validator.fully_validate(*args)
      @validation_errors.empty?
    end

    def validation_errors
      valid? unless @validation_errors
      @validation_errors
    end

    def make
      require @template_file_path
      Rodolfo::Template.new(@data).render
    end
  end
end
