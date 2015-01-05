require 'registry'

module Core
  module Connection
    autoload :Http, 'core/connection/http'
    autoload :Smtp, 'core/connection/smtp'
  end

  module ConnectionFactory
    autoload :Http, 'core/connection_factory/http'
    autoload :Smtp, 'core/connection_factory/smtp'
  end

  autoload :ActionPlan, 'core/entity/action_plan'
  autoload :Article, 'core/entity/article'
  autoload :ArticleLink, 'core/entity/article_link'
  autoload :Category, 'core/entity/category'
  autoload :Entity, 'core/entity'
  autoload :NewsArticle, 'core/entity/news_article'
  autoload :NewsCollection, 'core/entity/news_collection'
  autoload :Other, 'core/entity/other'
  autoload :SearchResult, 'core/entity/search_result'
  autoload :SearchResultCollection, 'core/entity/search_result_collection'
  autoload :StaticPage, 'core/entity/static_page'
  autoload :Customer, 'core/entity/customer'

  module Feedback
    autoload :Base, 'core/entity/feedback/base'
    autoload :Article, 'core/entity/feedback/article'
    autoload :Technical, 'core/entity/feedback/technical'
  end

  autoload :ActionPlanReader, 'core/interactor/action_plan_reader'
  autoload :ArticlePreviewer, 'core/interactor/article_previewer'
  autoload :ArticleReader, 'core/interactor/article_reader'
  autoload :CategoryReader, 'core/interactor/category_reader'
  autoload :CategoryTreeReader, 'core/interactor/category_tree_reader'
  autoload :FeedbackWriter, 'core/interactor/feedback_writer'
  autoload :NewsArticleReader, 'core/interactor/news_article_reader'
  autoload :NewsReader, 'core/interactor/news_reader'
  autoload :NewsletterSubscriptionCreator, 'core/interactor/newsletter_subscription_creator'
  autoload :Searcher, 'core/interactor/searcher'
  autoload :StaticPageReader, 'core/interactor/static_page_reader'

  module Interactors
    module Customer
      autoload :Finder, 'core/interactor/customer/finder'
      autoload :Creator, 'core/interactor/customer/creator'
      autoload :Updater, 'core/interactor/customer/updater'
    end

    autoload :UserUpdater, 'core/interactor/user_updater'
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

    module CallbackRequestable
      autoload :Static, 'core/repository/callback_requestable/static'
    end

    module Feedback
      autoload :Email, 'core/repository/feedback/email'
    end

    module Customers
      autoload :Fake, 'core/repository/customers/fake'
      autoload :Cream, 'core/repository/customers/cream'
    end

    module CMS
      autoload :CMS, 'core/repository/cms/cms'
      autoload :BlockComposer, 'core/repository/cms/block_composer'
      autoload :Preview, 'core/repository/cms/preview'
      autoload :AttributeBuilder, 'core/repository/cms/attribute_builder'
    end

    module News
      autoload :PublicWebsite, 'core/repository/news/public_website'
    end

    module NewsletterSubscriptions
      autoload :PublicWebsite, 'core/repository/newsletter_subscriptions/public_website'
    end

    module RecommendedTools
      autoload :Static, 'core/repository/recommended_tools/static'
    end

    module SavedTools
      autoload :Static, 'core/repository/saved_tools/static'
    end

    module StaticPages
      autoload :PublicWebsite, 'core/repository/static_pages/public_website'
    end

    module Search
      autoload :ContentService, 'core/repository/search/content_service'
      autoload :GoogleCustomSearchEngine, 'core/repository/search/google_custom_search_engine'
    end

    module Users
      autoload :Default, 'core/repository/users/default'
    end
  end
end
