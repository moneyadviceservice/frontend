module Core
  class Article
    include ActiveModel::Validations

    attr_accessor :id, :url, :title, :description, :body

    validates_presence_of :id, :url, :title, :body

    private :id=

    def initialize(id, url: url, title: title, description: description, body: body)
      self.id          = id
      self.url         = url
      self.title       = title
      self.description = description
      self.body        = body
    end
  end
end
