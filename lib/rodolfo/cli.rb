require 'thor'
require_relative 'meta'
require_relative 'rodolfo'

module Rodolfo
  # Rodolfo CLI
  class CLI < Thor

    desc 'render PACKAGE PATH', 'render a rodolfo package path'
    option 'skip-validation', aliases: ['-sv'], type: :boolean, default: :false,
                              desc: 'Skip schema validation'
    option :strict, type: :boolean, default: :false,
                    desc: 'Missing fields will not validate'
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

    def help(*args, &block)
      puts "Rodolfo v#{Rodolfo::VERSION}"
      super(*args, &block)
    end

  end
end
