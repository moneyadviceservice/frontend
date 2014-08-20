Rails.application.routes.draw do

  def not_implemented
    -> (env) { [501, {}, []] }
  end

  get '/' => redirect('/en')
  resource :beta_opt_out, only: [:create], path: 'opt-out'

  scope '/:locale', locale: /en|cy/ do
    root 'home#show'

    if Feature.active?(:registration)
      devise_for :users, only: [:registrations],
                 controllers:  { registrations: 'registrations' }
    else
      scope '/users' do
        match '/sign_up', to: not_implemented, via: 'get', as: 'new_user_registration'
        match '/edit', to: not_implemented, via: 'get', as: 'edit_user_registration'
      end
    end

    if Feature.active?(:sign_in)
      devise_for :users, only: [:sessions, :passwords],
                         controllers: { sessions: 'sessions' }
      scope '/users' do
        match '/password/new', to: not_implemented, as: 'new_password', via: 'get'
      end
    else
      scope '/users' do
        match '/sign_in', to: not_implemented, via: 'get', as: 'new_user_session'
        match '/sign_out', to: not_implemented, via: 'delete', as: 'destroy_user_session'
      end
    end

    Feature.with(:pensions_calculator) do
      mount PensionsCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:pensions_calculator)
    end

    match '/tools/:id', to: not_implemented, via: 'get', as: 'tool'

    resources :action_plans, only: 'show'
    resources :articles,
              only:        'show',
              constraints: ValidResource.new(:article) do
                resource :feedback, only: [:new, :create], controller: :article_feedbacks
              end
    resources :categories, only: 'show',
              constraints:       ValidResource.new(:category)
    resources :search_results, only: 'index', path: 'search'
    resources :news, only: [:show, :index]
    resource :advice, only: :show

    get 'campaigns/revealed-the-true-cost-of-buying-a-car', to: 'car_campaigns#show'
    get 'campaigns/edrychwch-cost-gwirioneddol-prynu-car', to: 'car_campaigns#show'

    resources :static_pages,
              path:        'static',
              only:        'show',
              constraints: ValidResource.new(:static_page)

    resource :feedback, only: [:new, :create], controller: :technical_feedbacks

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'

    resource :newsletter_subscription, only: :create, path: 'newsletter-subscription'

    resource :styleguide,
             controller:  'styleguide',
             only:        'show',
             constraints: { locale: I18n.default_locale } do
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
          get 'pages_feedback_information', path: '/feedback_information'
          get 'pages_feedback_technical', path: '/feedback_technical'
          get 'pages_feedback_advice', path: '/feedback_advice'
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

  match '*path', via: :all, to: not_implemented

end
