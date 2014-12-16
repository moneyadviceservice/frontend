module Core
  class Article < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :title, :description, :body, :categories
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
      [
        ArticleLink.new('Get some help with debt.', '#'),
        ArticleLink.new('Get some help with credit cards.', '#'),
        ArticleLink.new('Calculate how to get more money.', '#')
      ]
    end

  end
end
