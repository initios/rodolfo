module Rodolfo
  # Package rendering failed
  class RenderError < RuntimeError
    attr_reader :errors

    def initialize(errors)
      @errors = errors
    end
  end

  # Schema validation failed
  class SchemaValidationError < RenderError
  end
end
