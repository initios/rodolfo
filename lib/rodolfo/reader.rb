require 'json'
require 'pdf/reader'

# Create PDFs from the CLI using Prawn
module Rodolfo
  # Reads a PDF info and metadata
  class Reader
    def initialize(pdf)
      @reader = PDF::Reader.new pdf
    end

    def to_h
      {
        PdfVersion: @reader.pdf_version,
        Info: @reader.info,
        Meta: @reader.metadata,
        Pages: @reader.page_count
      }
    end

    def to_json
      JSON.pretty_generate to_h
    end
  end
end
