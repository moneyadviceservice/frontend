Rails.application.routes.draw do
  resource :styleguide, controller: 'styleguide', only: 'show' do
    member do
      get 'sass'
      get 'base'
      get 'components'
      get 'forms'
      get 'article_demo'
      get 'html'
      get 'variables'
      get 'javascript'
      get 'ruby'

      scope 'css' do
        get 'css_overview', path: '/css'
        get 'css_base', path: '/base'
        get 'css_article_demo', path: '/article-demo'
      end

      scope 'sass' do
        get 'sass_overview', path: '/sass'
        get 'sass_variables', path: '/variables'
      end
    end
  end
end
