module StickyNewsletterVisibility
  class StickyNewsletterFilter

    BLACKLIST_FILTERED = [ '',
                           'categories',
                           'corporate',
                           'tools',
                           'videos',
                           'corporate_categories',
                           'sitemap',
                           'users'
                         ]

    def initialize(slug)
      @slug = slug
    end

    def blacklist_page?
      blacklist_filter_results.any?
    end

    private

    def blacklist_filter_results
      BLACKLIST_FILTERED.map do |pattern|
        if pattern.empty?
          '/en' == @slug || '/cy' == @slug
        else
          /\/(en|cy)\/#{pattern}/i.match(@slug)
        end
      end
    end
  end

  def display_sticky_newsletter?
    slug = request.url.gsub(request.base_url, '')
    !StickyNewsletterFilter.new(slug).blacklist_page?
  end
end
