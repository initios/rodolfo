require 'thor'
require_relative 'exceptions'
require_relative 'meta'
require_relative 'renderer'

module Rodolfo
  # Rodolfo CLI
  class CLI < Thor
    # def self.exit_on_failure?
    #   true
    # end

    map %w(--version -v) => :__print_version

    desc '--version, -v', 'print the version'
    def __print_version
      puts VERSION
    end

    desc 'schema PACKAGE PATH', 'print the package json schema'
    def schema(package_path)
      puts Rodolfo::Renderer.new(package_path, {}).json_schema
    end

    desc 'render PACKAGE PATH', 'render a rodolfo package path'
    def render(package_path)
      data = $stdin.tty? ? {} : JSON.parse($stdin.read, symbolize_names: true)
      package = Rodolfo::Renderer.new package_path, data
      STDOUT.write package.render
      exit 0
    rescue RenderError, SchemaValidationError => error
      STDOUT.write error.errors
      exit 2
    end

    def help(*args, &block)
      puts "Rodolfo v#{Rodolfo::VERSION}"
      super(*args, &block)
    end
  end
end
