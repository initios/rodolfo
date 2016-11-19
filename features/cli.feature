Feature: Rodolfo CLI
    As a developer
    I want to generate pdf reports from the cli
    In order to be able to use it the reports from any programming language

    Background:
      Given a file named "myrecipe/schema.json" with:
      """
      {
        "id": "http://www.example.com/json-schema/v2/tpl/example-template",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example Template"
      }
      """
      And a file named "myrecipe/template.rb" with:
      """
      module Rodolfo
        # A Rodolfo Prawn pdf generator
        class Template
          def initialize(data)
            @data = data
          end

          # Prawn config
          def config
            { }
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
      And a file named "myrecipe/data.json" with:
      """
      {"msg": "Hello World"}
      """

    Scenario: Getting the current cli version
      When I run `rodolfo --version`
      Then the exit status should be 0
      And the stdout should contain the current Rodolfo version

    Scenario: Getting the json schema of a template
      When I run `rodolfo schema myrecipe`
      Then the output should contain "Example Template"

    Scenario: Running the cli without specifying a template
      When I run `rodolfo`
      Then the exit status should be 0
      And the output should contain "rodolfo help [COMMAND]"

    Scenario: Generate a pdf
      When I run `rodolfo render myrecipe` interactively
      And I pipe in the file "myrecipe/data.json"
      Then the exit status should be 0
      And the stdout should contain the generated pdf contents
      And the pdf should include:
      | Hello World |
      And the pdf should contain 1 page
      And the pdf should contain metadata

    Scenario: Generate a pdf on a file
      When I run `rodolfo render myrecipe --save-to output.pdf` interactively
      And I pipe in the file "myrecipe/data.json"
      Then the exit status should be 0
      And the file named "output.pdf" should exist and be a valid pdf
      And the pdf should include:
      | Hello World |
      And the pdf should contain 1 page

    Scenario: Generate a pdf with missing field required on json schema
      Given a file named "myrecipe/schema.json" with:
      """
      {
        "id": "http://www.example.com/json-schema/v2/tpl/example-template",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example",
        "required": ["name", "country"],
        "properties": {
            "name": {"type": "string"},
            "country": {"type": "string"}
        }
      }
      """
      And a file named "myrecipe/data.json" with:
      """
      {"name": "Carlos"}
      """
      When I run `rodolfo render myrecipe` interactively
      And I pipe in the file "myrecipe/data.json"
      Then the exit status should be 2
      And the stdout should contain "did not contain a required property of 'country' in schema"

    Scenario: Generate a pdf with missing field NOT required on json schema
      It should fail anyway because of
      the json parser "strict" option

      Given a file named "myrecipe/schema.json" with:
      """
      {
        "id": "http://www.example.com/json-schema/v2/tpl/example-template",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example",
        "required": [],
        "properties": {
            "name": {"type": "string"},
            "country": {"type": "string"}
        }
      }
      """
      And a file named "myrecipe/data.json" with:
      """
      {"name": "Carlos"}
      """
      When I run `rodolfo render myrecipe` interactively
      And I pipe in the file "myrecipe/data.json"
      Then the exit status should be 2
      And the stdout should contain "did not contain a required property of 'country' in schema"

    Scenario: Generate a pdf with missing data which is not required on the json schema
      Given a file named "myrecipe/schema.json" with:
      """
      {
        "id": "http://www.example.com/json-schema/v2/tpl/example-template",
        "$schema": "http://json-schema.org/draft-04/schema#",
        "description": "Example",
        "required": ["name"],
        "properties": {
            "name": {"type": "string"}
        }
      }
      """
      And a file named "myrecipe/template.rb" with:
      """
      module Rodolfo
        # A Rodolfo Prawn pdf generator
        class Template
          def initialize(data)
            @data = data
          end

          # Prawn config
          def config
            { }
          end

          def to_proc
            data = @data

            proc do
              text @data[:name]
              text @data[:user][:name]
            end
          end
        end
      end

      """
      And a file named "myrecipe/data.json" with:
      """
      {"name": "Carlos"}
      """
      When I run `rodolfo render myrecipe` interactively
      And I pipe in the file "myrecipe/data.json"
      Then the exit status should be 2
      And the stdout should contain "Missing or incorrect data, template can't be rendered"

    Scenario: Getting pdf info
      Given a file example.pdf
      When I run `rodolfo read example.pdf`
      Then the exit status should be 0

    Scenario: Scaffold a recipe
      When I run `rodolfo g new-recipe "an example recipe"`
      Then the exit status should be 0
      And the directory "new-recipe" should exist
      And the file "new-recipe/data.json" should exist
      And the file "new-recipe/schema.json" should exist
      And the file "new-recipe/template.rb" should exist
