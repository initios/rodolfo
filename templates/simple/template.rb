module Rodolfo
  class Template < Prawn::Document
    def initialize(data)
      super
      @data = data
    end

    def render
      text @data[:msg]
      super
    end
  end
end
