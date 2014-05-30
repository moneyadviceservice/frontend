class ValidArticle
  BLACKLIST = %w(about-our-debt-work am-ein-gwaith-dyled
                 debt-publications cyhoeddiadau-ar-ddyledion
                 partners-overview-parhub
                 partner-reg-parhub
                 syndicating-tools-parhub
                 video-syndication-parhub
                 toolkits-parhub pecynnau-cymorth-cyngor-ariannol
                 linking-parhub
                 examples-parhub
                 licence-agreement-parhub)

  def matches?(request)
    BLACKLIST.exclude?(request.parameters['id'])
  end
end

class ValidCategory
  BLACKLIST = %w(partners
                 partners-uc-banks
                 partners-uc-landlords
                 resources-for-professionals-working-with-young-people-and-parents)

  def matches?(request)
    BLACKLIST.exclude?(request.parameters['id'])
  end
end

Rails.application.routes.draw do
  get '/' => redirect("/en")
  resource :beta_opt_out, only: [:create, :destroy], path: 'opt-out'

  scope '/:locale', locale: /en|cy/ do
    root 'home#show'
    resources :action_plans, only: 'show'
    resources :articles,
              only: 'show',
              constraints: ValidArticle.new
    resources :categories, only: 'show',
              constraints: ValidCategory.new
    resources :search_results, only: 'index', path: 'search'

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'
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
          get 'pages_guide_v2', path: '/guide_v2'
          get 'pages_error', path: '/error'
          get 'pages_action_plan', path: '/action-plan'
          get 'pages_action_plan_v2', path: '/action-plan_v2'
          get 'pages_home', path: '/home'
          get 'pages_search_results', path: '/search_results'
          get 'pages_search_results_v2', path: '/search_results_v2'
          get 'pages_parent_category_page', path: '/parent_category_page'
          get 'pages_parent_category_page_v2', path: '/parent_category_page_v2'
          get 'pages_child_category_page', path: '/child_category_page'
          get 'pages_grandchild_category_page', path: '/grandchild_category_page'
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

  match '*path', via: :all, to: -> env { [501, {}, []] }
end
