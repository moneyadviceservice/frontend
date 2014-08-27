class Section
  attr_accessor :name, :articles
  private :name=, :articles=

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
end
