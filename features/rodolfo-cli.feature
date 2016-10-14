Feature: Rodolfo CLI
    As a developer
    I want to generate pdf reports from a simple cli
    In order to maintain them isolated from the system

    Scenario: Getting the current cli version
      When I run `rodolfo --version`
      Then the exit status should be 0
      And the output should contain the current Rodolfo version

# Then(/^(?:the )?(output|stderr|stdout)(?: from "([^"]*)")? should( not)? contain( exactly)? "([^"]*)"$/) do |channel, cmd, negated, exactly, expected|


    # Scenario: Running the cli without stdin
    #     When I run `itemplates` interactively
    #     And I close the stdin stream
    #     Then it should fail with:
    #     """
    #     Input data not given
    #     """

    # Scenario: Running the cli with valid args and stdin data
    #     When I run `itemplates` interactively
    #     When I pipe in valid json data
    #     Then the exit status should be 0
    #     And the stderr should not contain anything
    #     And the stdout should contain the generated pdf contents
    #     And the pdf should contain:
    #     | Kaleido Logistics |
    #     | Proyecto de ejemplo de Kaleido |
    #     And the pdf should contain 3 pages
