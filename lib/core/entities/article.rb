module Core
  class Article
    include ActiveModel::Validations

    attr_accessor :id, :url, :title, :description, :body

    validates_presence_of :id, :url, :title, :description, :body
    validates_url :url

    private :id=

    def initialize(id, attributes = {})
      self.id = id

      Array(attributes).each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
