Rails.application.routes.draw do
  resource :styleguide, controller: 'styleguide', only: 'show' do
    member do
      get 'css'
      get 'overview'
      get 'base'
      get 'components'
      get 'form_demo'
      get 'article_demo'
      get 'html'
      get 'sass'
      get 'lib'
      get 'javascript'
      get 'ruby'
    end
  end
end
