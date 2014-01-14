Rails.application.routes.draw do
  root 'home#index'

  scope '/:locale' do
    get '/', to: 'home#index'

    resource :styleguide,
             controller:  'styleguide',
             only:        'show',
             constraints: { locale: I18n.default_locale } do
      member do
        get 'components'
        get 'forms'
        get 'html'
        get 'javascript'
        get 'ruby'

        scope 'css' do
          get 'css_overview', path: '/'
          get 'css_base', path: '/base'
          get 'css_article_demo', path: '/article-demo'
        end

        scope 'sass' do
          get 'sass_overview', path: '/'
          get 'sass_variables', path: '/variables'
        end
      end
    end
  end
end
