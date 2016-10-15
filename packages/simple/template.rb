module Rodolfo
  class Template
    def initialize(data)
      data = @data
    end

    def to_proc
      proc do
        text @data[:msg]
      end
    end
  end
end
