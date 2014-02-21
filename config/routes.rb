class ValidArticle
  BLACKLIST = %w(about-our-debt-work am-ein-gwaith-dyled
                 debt-publications cyhoeddiadau-ar-ddyledion)

  def matches?(request)
    BLACKLIST.exclude?(request.parameters['id'])
  end
end

Rails.application.routes.draw do
  root 'home#show'
  post :opt_out, to: 'opt_out#create'

  scope '/:locale' do
    resources :action_plans, only: 'show'
    resources :articles,
              only:        'show',
              constraints: ValidArticle.new

    resource :styleguide,
             controller:  'styleguide',
             only:        'show',
             constraints: { locale: I18n.default_locale } do
      member do
        get 'components'
        get 'forms'
        get 'layouts'
        get 'html'
        get 'javascript'
        get 'ruby'

        scope 'pages' do
          get 'pages', path: '/'
          get 'pages_guide', path: '/guide'
          get 'pages_error', path: '/error'
          get 'pages_action_plan', path: '/action-plan'
          get 'pages_homepage', path: '/homepage'
        end

        scope 'css' do
          get 'css_overview', path: '/'
          get 'css_basic', path: '/basic'
          get 'css_article_demo', path: '/article-demo'
          get 'css_default_styles', path: '/default-styles'
          get 'css_header_non_js', path: '/header-non-js'
          get 'css_header_js', path: '/header-js'
        end

        scope 'sass' do
          get 'sass_overview', path: '/'
          get 'sass_variables', path: '/variables'
        end
      end
    end
  end

  match '*path', via: %W(get post), to: -> env { [501, {}, []] }
end
