module Rodolfo
  # A Rodolfo Prawn pdf generator
  class Template < Prawn::Document
    def initialize(data, options)
      @data = data
      super options
    end

    def render
      text @data[:msg]
      super
    end
  end
end
