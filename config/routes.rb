Rails.application.routes.draw do
  resource :styleguide, controller: 'styleguide', only: 'show' do
    member do
      get 'components'
      get 'css'
      get 'javascript'
      get 'ruby'
    end
  end
end
