module BudgetWarning
  ANNOUNCEMENT_DAY   = 6
  ANNOUNCEMENT_MONTH = 4
  ANNOUNCEMENT_YEAR  = 2022
  WHITELIST = YAML.load_file('config/budget_warning_tools.yml')

  class Announcement
    attr_reader :date

    def initialize
      @date = Date.new(ANNOUNCEMENT_YEAR,
                       ANNOUNCEMENT_MONTH,
                       ANNOUNCEMENT_DAY)
    end

    def go_live?
      Time.zone.today >= date
    end
  end

  def display_banner_warning?
    BudgetWarning::Announcement.new.go_live? && whitelisted?
  end
  module_function :display_banner_warning?

  def whitelisted?
    WHITELIST.include? request.url.gsub(request.base_url, '')
  end
end
