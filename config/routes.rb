Rails.application.routes.draw do
  resource :styleguide, controller: 'styleguide', only: 'show' do
    member do
      get 'css'
      get 'html'
      get 'javascript'
      get 'ruby'
      get 'sass'
    end
  end
end
