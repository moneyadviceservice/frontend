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
  autoload :HomePage, 'core/entity/home_page'
  autoload :Contact, 'core/entity/contact'
  autoload :CorporateArticle, 'core/entity/corporate_article'
  autoload :ArticleLink, 'core/entity/article_link'
  autoload :Category, 'core/entity/category'
  autoload :CorporateCategory, 'core/entity/corporate_category'
  autoload :Entity, 'core/entity'
  autoload :NewsArticle, 'core/entity/news_article'
  autoload :NewsCollection, 'core/entity/news_collection'
  autoload :NewsletterSubscription, 'core/entity/newsletter_subscription'
  autoload :Other, 'core/entity/other'
  autoload :SearchResult, 'core/entity/search_result'
  autoload :SearchResultCollection, 'core/entity/search_result_collection'
  autoload :StaticPage, 'core/entity/static_page'
  autoload :Customer, 'core/entity/customer'
  autoload :Video, 'core/entity/video'

  autoload :Footer, 'core/entity/footer'
  autoload :WebChat, 'core/entity/web_chat'

  module Feedback
    autoload :Base, 'core/entity/feedback/base'
    autoload :Article, 'core/entity/feedback/article'
    autoload :Technical, 'core/entity/feedback/technical'
  end

  autoload :BaseContentReader, 'core/interactor/base_content_reader'
  autoload :HomePageReader, 'core/interactor/home_page_reader'
  autoload :HomePagePreviewer, 'core/interactor/home_page_previewer'
  autoload :ActionPlanReader, 'core/interactor/action_plan_reader'
  autoload :ArticlePreviewer, 'core/interactor/article_previewer'
  autoload :ArticleReader, 'core/interactor/article_reader'
  autoload :CategoryReader, 'core/interactor/category_reader'
  autoload :CategoryTreeReader, 'core/interactor/category_tree_reader'
  autoload :CategoryTreeReaderWithDecorator, 'core/interactor/category_tree_reader_with_decorator'
  autoload :CorporateReader, 'core/interactor/corporate_reader'
  autoload :FeedbackWriter, 'core/interactor/feedback_writer'
  autoload :NewsArticleReader, 'core/interactor/news_article_reader'
  autoload :NewsReader, 'core/interactor/news_reader'
  autoload :NewsletterSubscriptionCreator, 'core/interactor/newsletter_subscription_creator'
  autoload :Searcher, 'core/interactor/searcher'
  autoload :StaticPageReader, 'core/interactor/static_page_reader'
  autoload :VideoReader, 'core/interactor/video_reader'
  autoload :VideoPreviewer, 'core/interactor/video_previewer'
  autoload :RedirectReader, 'core/interactor/redirect_reader'

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
      autoload :CMS, 'core/repository/action_plans/cms'
    end

    module Articles
      autoload :Fake, 'core/repository/articles/fake'
      autoload :PublicWebsite, 'core/repository/articles/public_website'
      autoload :CMS, 'core/repository/articles/cms'
    end

    module HomePages
      autoload :CMS, 'core/repository/home_pages/cms'
      autoload :Static, 'core/repository/home_pages/static'
    end

    module Corporate
      autoload :CMS, 'core/repository/corporate/cms'
    end

    module Videos
      autoload :PublicWebsite, 'core/repository/videos/public_website'
      autoload :CMS, 'core/repository/videos/cms'
    end

    module Categories
      autoload :Fake, 'core/repository/categories/fake'
      autoload :CMS, 'core/repository/categories/cms'
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
      autoload :CmsApi, 'core/repository/cms/cms_api'
      autoload :BlockComposer, 'core/repository/cms/block_composer'
      autoload :Preview, 'core/repository/cms/preview'
      autoload :AttributeBuilder, 'core/repository/cms/attribute_builder'
    end

    module News
      autoload :PublicWebsite, 'core/repository/news/public_website'
      autoload :CMS, 'core/repository/news/cms'
    end

    module NewsletterSubscriptions
      autoload :Cream, 'core/repository/newsletter_subscriptions/cream'
      autoload :Fake, 'core/repository/newsletter_subscriptions/fake'
    end

    module RecommendedTools
      autoload :Static, 'core/repository/recommended_tools/static'
    end

    module SavedTools
      autoload :Static, 'core/repository/saved_tools/static'
    end

    module StaticPages
      autoload :PublicWebsite, 'core/repository/static_pages/public_website'
      autoload :Cms, 'core/repository/static_pages/cms'
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
