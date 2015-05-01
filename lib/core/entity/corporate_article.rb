module Core
  class CorporateArticle < Article
    def previous_link
      corporate_navigation_link 'previous_link'
    end

    def next_link
      corporate_navigation_link 'next_link'
    end

    private

    def corporate_navigation_link(key)
      return nil if related_content.nil? || related_content[key].blank?

      build_corporate_article_link related_content[key]
    end

    def build_corporate_article_link(data)
      ArticleLink.new(data['title'], data['path'].sub('/articles/', '/corporate/'))
    end
  end
end
