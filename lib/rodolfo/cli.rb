require 'thor'
require_relative 'exceptions'
require_relative 'meta'
require_relative 'rodolfo'

module Rodolfo
  # Rodolfo CLI
  class CLI < Thor

    desc 'render PACKAGE PATH', 'render a rodolfo package path'
    def render(package_path)
      data = $stdin.tty? ? {} : JSON.parse($stdin.read, symbolize_names: true)
      package = Rodolfo::Package.new package_path, data
      STDOUT.write package.render
      exit 0
    rescue RenderError => error
      STDOUT.write error.errors
      exit 2
    end

    def help(*args, &block)
      puts "Rodolfo v#{Rodolfo::VERSION}"
      super(*args, &block)
    end

  end
end
