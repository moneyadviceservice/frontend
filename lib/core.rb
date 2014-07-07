require 'registry'

module Core
  autoload :Connection, 'core/connection'
  autoload :ConnectionFactory, 'core/connection_factory'

  autoload :ActionPlan, 'core/entity/action_plan'
  autoload :Article, 'core/entity/article'
  autoload :Category, 'core/entity/category'
  autoload :Entity, 'core/entity'
  autoload :NewsArticle, 'core/entity/news_article'
  autoload :NewsCollection, 'core/entity/news_collection'
  autoload :Other, 'core/entity/other'
  autoload :SearchResult, 'core/entity/search_result'
  autoload :SearchResultCollection, 'core/entity/search_result_collection'
  autoload :StaticPage, 'core/entity/static_page'

  autoload :ActionPlanReader, 'core/interactor/action_plan_reader'
  autoload :ArticleReader, 'core/interactor/article_reader'
  autoload :CategoryReader, 'core/interactor/category_reader'
  autoload :CategoryTreeReader, 'core/interactor/category_tree_reader'
  autoload :NewsArticleReader, 'core/interactor/news_article_reader'
  autoload :NewsReader, 'core/interactor/news_reader'
  autoload :Searcher, 'core/interactor/searcher'
  autoload :StaticPageReader, 'core/interactor/static_page_reader'

  module Newsletter
    autoload :Subscriber,   'core/interactor/newsletter/subscriber'
  end

  module Registry
    autoload :Connection, 'core/registry/connection'
    autoload :Repository, 'core/registry/repository'
  end

  module Repository
    autoload :Base, 'core/repository/base'
    autoload :Cache, 'core/repository/cache'
    autoload :VCR, 'core/repository/vcr'

    module ActionPlans
      autoload :PublicWebsite, 'core/repository/action_plans/public_website'
    end

    module Articles
      autoload :Fake, 'core/repository/articles/fake'
      autoload :PublicWebsite, 'core/repository/articles/public_website'
    end

    module Categories
      autoload :Fake, 'core/repository/categories/fake'
      autoload :PublicWebsite, 'core/repository/categories/public_website'
    end

    module News
      autoload :PublicWebsite, 'core/repository/news/public_website'
    end

    module StaticPages
      autoload :PublicWebsite, 'core/repository/static_pages/public_website'
    end

    module Newsletter
      module Subscriptions
        autoload :PublicWebsite, 'core/repository/newsletter/subscriptions/public_website'
      end
    end

    module Search
      autoload :ContentService, 'core/repository/search/content_service'
      autoload :FakeContentService, 'core/repository/search/fake_content_service'
      autoload :GoogleCustomSearchEngine, 'core/repository/search/google_custom_search_engine'
    end
  end
end
