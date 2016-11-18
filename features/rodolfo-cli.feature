Feature: Rodolfo CLI
    As a developer
    I want to generate pdf reports from a simple cli
    In order to maintain them isolated from the system

    Background:
      Given a file named "mypackage/schema.json" with:
      """
      {
        "id": "http://json-schema.org/draft-04/schema#",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example Template"
      }
      """
      And a file named "mypackage/template.rb" with:
      """
      module Rodolfo
        class Template < Prawn::Document
          def initialize(data)
            @data = data
            super
          end

          def render
            text @data[:msg]
            super
          end
        end
      end

      """
      And a file named "mypackage/data.json" with:
      """
      {"msg": "Hello World"}
      """

    Scenario: Getting the current cli version
      When I run `rodolfo --version`
      Then the exit status should be 0
      And the stdout should contain the current Rodolfo version

    Scenario: Getting the json schema of a template
      When I run `rodolfo schema mypackage`
      Then the output should contain "Example Template"

    Scenario: Running the cli without specifying a template
      When I run `rodolfo`
      Then the exit status should be 0
      And the output should contain "rodolfo help [COMMAND]"

    Scenario: Generate a pdf
      When I run `rodolfo render mypackage` interactively
      And I pipe in the file "mypackage/data.json"
      Then the exit status should be 0
      And the stdout should contain the generated pdf contents
      And the pdf should include:
      | Hello World |
      And the pdf should contain 1 page

    Scenario: Generate a pdf with missing field required on json schema
      Given a file named "mypackage/schema.json" with:
      """
      {
        "id": "http://json-schema.org/draft-04/schema#",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example",
        "required": ["name", "country"],
        "properties": {
            "name": {"type": "string"},
            "country": {"type": "string"}
        }
      }
      """
      And a file named "mypackage/data.json" with:
      """
      {"name": "Carlos"}
      """
      When I run `rodolfo render mypackage` interactively
      And I pipe in the file "mypackage/data.json"
      Then the exit status should be 2
      And the stdout should contain "did not contain a required property of 'country' in schema"

    Scenario: Generate a pdf with missing data which is not required on the json schema
      Given a file named "mypackage/schema.json" with:
      """
      {
        "id": "http://json-schema.org/draft-04/schema#",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example",
        "required": ["name"],
        "properties": {
            "name": {"type": "string"}
        }
      }
      """
      And a file named "mypackage/template.rb" with:
      """
      module Rodolfo
        class Template < Prawn::Document
          def initialize(data)
            @data = data
            super
          end

          def render
            text @data[:name]
            text @data[:user][:name]
            super
          end
        end
      end

      """
      And a file named "mypackage/data.json" with:
      """
      {"name": "Carlos"}
      """
      When I run `rodolfo render mypackage` interactively
      And I pipe in the file "mypackage/data.json"
      Then the exit status should be 2
      And the stdout should contain "Missing or incorrect data, template can't be rendered"
