module Rodolfo
  class Template < Prawn::Document
    def initialize(data)
      @data = data
      super
    end

    def render
      text @data[:msg]
      super
    end
  end
end
