module CampaignPage
  class Article
    attr_accessor :name
    private :name=

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
