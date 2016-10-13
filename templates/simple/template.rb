module Rodolfo
  def self.make_proc(data)
    proc do
      text data[:msg]
    end
  end
end
