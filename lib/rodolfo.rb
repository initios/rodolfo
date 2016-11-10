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
  ##
  # Represents a filesystem folder which should contain
  # - schema.json to perform the validation
  # - data.json as example data
  # - template.rb the pdf generator itself
  #
  # It handles methods for manipulate those files and the pdf generation
  class Package
    attr_reader :validation_errors

    def initialize(path, data)
      @path = Pathname.new(path).absolute? ? path : File.join(Dir.pwd, path)
      @data = data

      args = schema, @data, { errors_as_objects: true }
      @validation_errors = JSON::Validator.fully_validate(*args)
    end

    def schema
      json_file_path = File.join @path, 'schema.json'
      File.read json_file_path
    end

    def valid?
      @validation_errors.empty?
    end

    def make
      template_file_path = File.join @path, 'template'
      require template_file_path
      Rodolfo::Template.new(@data).render
    end
  end
end
