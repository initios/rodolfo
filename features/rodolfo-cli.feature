Feature: Rodolfo CLI
    As a developer
    I want to generate pdf reports from a simple cli
    In order to maintain them isolated from the system

    Scenario: Getting the current cli version
      When I run `rodolfo --version`
      Then the exit status should be 0
      And the stdout should contain the current Rodolfo version

    Scenario: Running the cli without specifying a template
      When I run `rodolfo`
      Then the exit status should be 1
      And the output should contain "-t, --template  template name"
