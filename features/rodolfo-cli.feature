Feature: Rodolfo CLI
    As a developer
    I want to generate pdf reports from a simple cli
    In order to maintain them isolated from the system

    Background:
      Given a file named "packages/mypackage/schema.json" with:
      """
      {
        "id": "http://json-schema.org/draft-04/schema#",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Simple Template"
      }
      """
      And a file named "packages/mypackage/template.rb" with:
      """
      module Rodolfo
        class Template
          def initialize(data)
            @data = data
          end

          def to_proc
            data = @data

            proc do
              text data[:msg]
            end
          end
        end
      end
      """
      And a file named "data.json" with:
      """
      {"msg": "Hello World"}
      """

    Scenario: Getting the current cli version
      When I run `rodolfo --version`
      Then the exit status should be 0
      And the stdout should contain the current Rodolfo version

    Scenario: Running the cli without specifying a template
      When I run `rodolfo`
      Then the exit status should be 1
      And the output should contain "-t, --template  template name"

    Scenario: Getting the json schema of a template
      When I run `rodolfo -t packages/mypackage --schema`
      Then the output should contain "http://json-schema.org/draft-04/schema#"

    Scenario: Generate a pdf on a file
      When I run `rodolfo -t packages/mypackage -o output.pdf` interactively
      And I pipe in the file "data.json"
      And I close the stdin stream
      Then the exit status should be 0
      And the file named "output.pdf" should exist and be a valid pdf
      And the pdf should include:
      | Hello World |
      And the pdf should contain 1 page

    Scenario: Generate a pdf on stdout
      When I run `rodolfo -t packages/mypackage` interactively
      And I pipe in the file "data.json"
      And I close the stdin stream
      Then the exit status should be 0
      And the stdout should contain the generated pdf contents
      And the pdf should include:
      | Hello World |
      And the pdf should contain 1 page
