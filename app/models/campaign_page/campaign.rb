module CampaignPage
  class Campaign
    include Enumerable

    WHITELIST= %w(
      cmo
      coping-with-unexpected-bills
      csa
      borrowing-get-the-facts
      budgeting-to-get-through-january
      free-debt-advice
      friends-life-lander
      get-set-for-summer
      interest-only-mortgages
      life-and-critical-illness
      paying-too-much-tax-on-savings
      save-gbp3-a-day-for-emergencies
      saving-for-a-holiday
      start-living-your-life-free-of-debt
      student-budgeting
      sw-saving-and-debt
      the-cost-of-caring
      the-true-cost-of-affording-a-home
      the-true-cost-of-borrowing
      uk-money-habits-study
      what-does-ma-think
      young-peoples-money-regrets
    ).freeze

    attr_accessor :name, :sections, :cost_calculator_link
    private :name=, :sections=, :cost_calculator_link=

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end

    def each(*args, &block)
      sections.each(*args, &block)
    end
  end
end
