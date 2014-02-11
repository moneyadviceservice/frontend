Rails.application.routes.draw do
  root 'home#show'

  scope '/:locale' do
    resources :action_plans, only: 'show'
    resources :articles, only: 'show'

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
        end

        scope 'sass' do
          get 'sass_overview', path: '/'
          get 'sass_variables', path: '/variables'
        end
      end
    end
  end
end
