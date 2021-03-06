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
      template('template.tt', "#{folder}/template.rb")
    end

    def four
      copy_file('data.tt', "#{folder}/data.json")
    end

    def five
      puts
      puts 'Recipe ready! Try it with:'
      puts "cat #{folder}/data.json | rodolfo render #{folder}" \
           " --save-to #{folder}.pdf"
    end
  end

  # Rodolfo CLI
  class CLI < Thor
    def self.exit_on_failure?
      true
    end

    map %w[--version -v] => :__print_version

    desc '--version, -v', 'print the version'
    def __print_version
      puts VERSION
    end

    desc 'schema RECIPE PATH', 'print the recipe json schema'
    def schema(recipe_path)
      puts Rodolfo::Renderer.new(recipe_path, {}).json_schema
    end

    desc 'read PDF', 'prints pdf metadata and rodolfo info'
    def read(pdf)
      puts Rodolfo::Reader.new(pdf).to_json
    end

    desc 'render RECIPE PATH [--save-to file.pdf] [--strict]',
         'render a rodolfo recipe'
    method_option 'save-to', type: :string, aliases: '-s'
    method_option 'strict', type: :boolean, default: false, aliases: '-t'
    def render(recipe_path)
      file_name = options['save-to']
      strict = options['strict']

      data = $stdin.tty? ? {} : JSON.parse($stdin.read, symbolize_names: true)
      content = Rodolfo::Renderer.new(recipe_path, data, strict).render

      file_name ? File.write(file_name, content) : STDOUT.write(content)
      exit 0
    rescue RenderError, SchemaValidationError => error
      STDOUT.write error.errors.to_json
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
