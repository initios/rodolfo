require 'pathname'
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'

require_relative 'json_schema'
require_relative 'exceptions'

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
