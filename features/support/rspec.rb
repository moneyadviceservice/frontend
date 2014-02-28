require 'timeout'

RSpec::Matchers.define(:become) do |expected|
  match do |block|
    begin
      Timeout.timeout(Capybara.default_wait_time) do
        sleep(0.1) until expected == block.call
        true
      end
    rescue TimeoutError
      false
    end
  end

  failure_message_for_should do |block|
    "expected `#{block.call}' to become `#{expected}'"
  end
end
