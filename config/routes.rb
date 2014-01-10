Rails.application.routes.draw do
  root "home#index"

  resource :styleguide, controller: 'styleguide', only: 'show' do
    member do
      get 'css'
      get 'html'
      get 'sass'
      get 'javascript'
      get 'ruby'
    end
  end
end
