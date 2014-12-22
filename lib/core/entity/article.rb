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
        build_article_link popular_link
      end
    end

    def previous_link
      navigation_link 'previous_link'
    end

    def next_link
      navigation_link 'next_link'
    end

    private

    def build_article_link(title_and_path)
      ArticleLink.new(title_and_path['title'], title_and_path['path'])
    end

    def navigation_link(key)
      return nil if related_content.nil? || related_content[key].blank?

      build_article_link related_content[key]
    end
  end
end
