module SurviveJanuary
  GO_LIVE_YEAR  = 2015
  GO_LIVE_MONTH = 12
  GO_LIVE_DAY   = 28

  class Campaign
    def initialize
      @go_live_date = Date.new(GO_LIVE_YEAR, GO_LIVE_MONTH, GO_LIVE_DAY)
    end

    def go_live?
      Date.today >= @go_live_date
    end
  end

  def display_campaign_promo?
    SurviveJanuary::Campaign.new.go_live?
  end
end
