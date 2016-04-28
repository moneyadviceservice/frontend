module BudgetWarning
    ANNOUNCEMENT_DAY   = 16
    ANNOUNCEMENT_MONTH = 3
    ANNOUNCEMENT_YEAR  = 2016

  class Announcement
    attr_reader :date

    def initialize
      @date = Date.new(ANNOUNCEMENT_YEAR,
                       ANNOUNCEMENT_MONTH,
                       ANNOUNCEMENT_DAY)
    end

    def go_live?
      (Date.today >= date) ? true : false
    end
  end

  def display_banner_warning?
    BudgetWarning::Announcement.new.go_live?
  end
  module_function :display_banner_warning?

  def whitelisted?
    whitelist = ['/en/tools/redundancy-pay-calculator/',
                 '/en/tools/workplace-pension-contribution-calculator/',
                 '/en/retirement-income-options/',
                 '/en/retirement-income-options/income-drawdown',
                 '/en/retirement-income-options/retirement-options',
                 '/cy/tools/cyfrifiannell-tal-diswyddo/',
                 '/cy/tools/cyfrifiannell-cyfraniadau-pensiwn-gweithle/',
                 '/cy/opsiynau-incwm-ymddeoliad/',
                 '/cy/opsiynau-incwm-ymddeoliad/income-drawdown',
                 '/cy/opsiynau-incwm-ymddeoliad/retirement-options']

    whitelist.include? request.url.gsub(request.base_url, '')
  end
  module_function :whitelisted?
end
