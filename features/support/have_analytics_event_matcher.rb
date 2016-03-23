require 'rspec/matchers'
require 'capybara'

RSpec::Matchers.define :have_analytics_event do |expected|
  def wait_until(timeout_in_seconds = Capybara.default_max_wait_time)
    Timeout.timeout(timeout_in_seconds) do
      sleep(0.1) until value = yield
      value
    end
  end

  match do |page|
    begin
      wait_until do
        @gaq = Array(page.evaluate_script('window.dataLayer'))
        @gaq.include?(expected)
      end
    rescue Timeout::Error
    end

    # can't use "include" matcher directly as it calls Module#include
    expect(@gaq).to be_include(expected)
  end

  failure_message_for_should do |page|
    <<-EOT
      Page analytics events recorded:
        - #{@gaq}
      is different from expected analytics event:
        - #{expected}
    EOT
  end
end
