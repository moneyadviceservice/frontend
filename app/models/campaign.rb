class Campaign
  include Enumerable

  attr_accessor :name, :sections
  private :name=, :sections=

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def each(*args, &block)
    sections.each(*args, &block)
  end
end
