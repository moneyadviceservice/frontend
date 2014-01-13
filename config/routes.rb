Rails.application.routes.draw do
  root 'home#index'

  scope '/:locale' do
    get '/', to: 'home#index'

    resource :styleguide,
             controller:  'styleguide',
             only:        'show',
             constraints: { locale: I18n.default_locale } do
      member do
        get 'css'
        get 'html'
        get 'sass'
        get 'javascript'
        get 'ruby'
      end
    end
  end
end
