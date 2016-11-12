require 'thor'
require_relative 'meta'
require_relative 'rodolfo'

module Rodolfo
  # Rodolfo CLI
  class CLI < Thor
    class_option :strict, type: :boolean, default: :false

    desc 'render package', 'render a rodolfo package'
    option '--skip-validation'
    def render(package_path)
      data = $stdin.tty? ? {} : JSON.parse($stdin.read, symbolize_names: true)
      package = Rodolfo::Package.new package_path, data

      unless options['--skip-validation'] || package.valid?
        STDOUT.write JSON.dump(package.validation_errors)
      end

      begin
        STDOUT.write package.make
        exit 0
      rescue NoMethodError
        STDOUT.write 'Missing or incorrect data, template can\'t be rendered'
        exit 2
      end
    end

    # def schema(package_path)
    # end

    def help
      puts "Rodolfo v#{Rodolfo::VERSION}"
      super
    end

  end
end
