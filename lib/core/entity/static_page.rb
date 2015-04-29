module Core
  class StaticPage < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :title, :description, :body, :label, :meta_description,
                  :translations

    validates_presence_of :title

    def title
      @title || @label
    end

    def description
      @description || @meta_description
    end

    def alternates
      @translations
    end

    def alternates=(alternates)
      @alternates = alternates.map do |alternate|
        Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end

    def translations=(translations)
      @translations = translations.map do |translation|
        Alternate.new(*translation.values_at('label', 'link', 'language')).tap do |alt|
          alt.url = alt.url.gsub('corporate', 'static')
        end
      end
    end
  end
end
