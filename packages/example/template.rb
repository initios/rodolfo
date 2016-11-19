module Rodolfo
  # A Rodolfo Prawn pdf generator
  class Template
    def initialize(data)
      @data = data
    end

    # Prawn config
    def config
      {
        page_layout: :portrait
      }
    end

    def to_proc
      data = @data

      proc do
        text data[:msg]
      end
    end
  end
end
