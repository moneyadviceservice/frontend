class Campaign
  attr_accessor :name, :sections
  private :name=, :sections=

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
