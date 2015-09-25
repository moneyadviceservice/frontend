module Core
  class Video < Entity
    attr_accessor :type, :title, :description, :body, :categories

    validates_presence_of :title, :body

    def redirect?
      false
    end
  end
end
