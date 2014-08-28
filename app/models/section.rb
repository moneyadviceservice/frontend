class Section
  include Enumerable

  attr_accessor :name, :articles
  private :name=, :articles=

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def each(*args, &block)
    articles.each(*args, &block)
  end
end
