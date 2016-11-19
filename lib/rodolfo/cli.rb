require 'thor'
require_relative 'exceptions'
require_relative 'meta'
require_relative 'reader'
require_relative 'renderer'

module Rodolfo
  # Rodolfo recipe generator
  class Generator < Thor::Group
    argument :folder, type: :string, desc: 'Recipe folder name'
    argument :description, type: :string, desc: 'Recipe description'

    include Thor::Actions

    def self.source_root
      File.join __dir__, 'templates'
    end

    def one
      puts Generator.source_root
      empty_directory(folder)
    end

    def two
      template('schema.tt', "#{folder}/schema.json")
    end

    def three
      copy_file('template.tt', "#{folder}/template.rb")
    end

    def four
      copy_file('data.tt', "#{folder}/data.json")
    end

    def five
      puts
      puts 'Recipe ready! Try it with:'
      puts "cat #{folder}/data.json | rodolfo render #{folder} --save-to #{folder}.pdf"
    end
  end

  # Rodolfo CLI
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    map %w(--version -v) => :__print_version

    desc '--version, -v', 'print the version'
    def __print_version
      puts VERSION
    end

    desc 'schema PACKAGE PATH', 'print the package json schema'
    def schema(package_path)
      puts Rodolfo::Renderer.new(package_path, {}).json_schema
    end

    desc 'read PDF', 'prints pdf metadata and rodolfo info'
    def read(pdf)
      puts Rodolfo::Reader.new(pdf).to_json
    end

    desc 'render PACKAGE PATH [--save-to file.pdf]', 'render a rodolfo package'
    method_option 'save-to', type: :string, aliases: '-s'
    def render(package_path)
      data = $stdin.tty? ? {} : JSON.parse($stdin.read, symbolize_names: true)
      package = Rodolfo::Renderer.new package_path, data

      content = package.render

      file_name = options['save-to']
      file_name ? File.write(file_name, content) : STDOUT.write(content)
      exit 0
    rescue RenderError, SchemaValidationError => error
      STDOUT.write error.errors
      exit 2
    end

    def help(*args, &block)
      puts "Rodolfo v#{Rodolfo::VERSION}"
      super(*args, &block)
    end

    register(Generator, 'generator', 'generator FOLDER DESCRIPTION',
             'Scaffold new recipe')
  end
end
