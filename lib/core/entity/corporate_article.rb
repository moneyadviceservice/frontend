module Core
  class CorporateArticle < Article
    private

    def build_article_link(data)
      ArticleLink.new(data['title'], data['path'].sub('/articles/', '/corporate/'))
    end
  end
end
