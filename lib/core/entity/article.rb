module Core
  class Article < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :title, :description, :body, :categories, :related_content
    attr_reader :alternates

    validates_presence_of :title, :body

    def alternates=(alternates)
      @alternates = alternates.map do |alternate|
        Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end

    def only_child?
      categories.compact.one?
    end

    def callback_requestable?
      Repository::CallbackRequestable::Static.new(self).call
    end

    def popular_links
      return [] if related_content.blank?
      related_content['popular_links'].map do |popular_link|
        ArticleLink.new(popular_link['title'], popular_link['path'])
      end
    end

  end
end
