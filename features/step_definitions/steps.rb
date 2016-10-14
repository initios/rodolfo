Then(/^the stdout should contain the current Rodolfo version$/) do
  step %(the output should contain "#{Rodolfo::VERSION}")
end
