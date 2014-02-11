module Core
  class Article
    include ActiveModel::Validations

    attr_accessor :id, :title, :description, :body
    private :id=

    validates_presence_of :id, :title, :body

    def initialize(id, attributes = {})
      self.id = id

      Array(attributes).each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
