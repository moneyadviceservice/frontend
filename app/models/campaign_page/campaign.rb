module CampaignPage
  class Campaign
    include Enumerable

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
