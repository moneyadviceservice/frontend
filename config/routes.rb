class ValidResource

  BLACKLIST = {
    :article     => %w(about-our-debt-work am-ein-gwaith-dyled
                       debt-publications cyhoeddiadau-ar-ddyledion
                       partners-overview-parhub
                       partner-reg-parhub
                       syndicating-tools-parhub
                       video-syndication-parhub
                       toolkits-parhub pecynnau-cymorth-cyngor-ariannol
                       linking-parhub
                       examples-parhub
                       licence-agreement-parhub),
    :category    => %w(partners
                       partners-uc-banks
                       partners-uc-landlords
                       resources-for-professionals-working-with-young-people-and-parents),
    :static_page => %w(accessibility hygyrchedd)
  }

  attr_accessor :type

  def initialize(type)
    self.type = type
  end

  def matches?(request)
    BLACKLIST[type].exclude?(request.parameters['id'])
  end
end

Rails.application.routes.draw do
  NOT_IMPLEMENTED = -> (env) { [501, {}, []] }

  get '/' => redirect("/en")
  resource :beta_opt_out, only: [:create, :destroy], path: 'opt-out'

  scope '/:locale', locale: /en|cy/ do
    root 'home#show'

    scope '/users' do
      match '/sign_in', to: NOT_IMPLEMENTED, via: 'get', as: 'new_user_session'
      match '/sign_out', to: NOT_IMPLEMENTED, via: 'delete', as: 'destroy_user_session'
      match '/sign_up', to: NOT_IMPLEMENTED, via: 'get', as: 'new_user_registration'
      match '/edit', to: NOT_IMPLEMENTED, via: 'get', as: 'edit_user_registration'
    end

    resources :action_plans, only: 'show'
    resources :articles,
              only: 'show',
              constraints: ValidResource.new(:article)
    resources :categories, only: 'show',
              constraints: ValidResource.new(:category)
    resources :search_results, only: 'index', path: 'search'
    resources :news, only: [:show, :index]

    get 'campaigns/revealed-the-true-cost-of-buying-a-car', to: "car_campaigns#show"
    get 'campaigns/edrychwch-cost-gwirioneddol-prynu-car', to: "car_campaigns#show"

    resources :static_pages,
              path:        'static',
              only:        'show',
              constraints: ValidResource.new(:static_page)

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'

    resource :newsletter_subscription, only: :create, path: 'newsletter-subscription'

    resource :styleguide,
             controller: 'styleguide',
             only: 'show',
             constraints: {locale: I18n.default_locale} do
      member do

        scope 'components' do
          get 'components_common', path: '/common'
          get 'components_website', path: '/website'
        end

        get 'forms'
        get 'layouts'
        get 'html'
        get 'javascript'

        scope 'pages' do
          get 'pages', path: '/'
          get 'pages_guide', path: '/guide'
          get 'pages_error', path: '/error'
          get 'pages_news_article', path: '/news_article'
          get 'pages_action_plan', path: '/action_plan'
          get 'pages_news_index', path: '/news_index'
          get 'pages_home', path: '/home'
          get 'pages_search_results', path: '/search_results'
          get 'pages_parent_category_page', path: '/parent_category_page'
          get 'pages_child_category_page', path: '/child_category_page'
          get 'pages_contact', path: '/contact'
        end

        scope 'css' do
          get 'css_overview', path: '/'
          get 'css_basic', path: '/typography'
          get 'css_article_demo', path: '/article-demo'
          get 'css_default_styles', path: '/default-styles'
        end

      end
    end
  end

  match '*path', via: :all, to: NOT_IMPLEMENTED
end
