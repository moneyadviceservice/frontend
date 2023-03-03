class CorporateCategoriesConstraint
  def initialize
    @ids = ['corporate-home']
  end

  def matches?(request)
    !@ids.include?(request.params[:id])
  end
end

Rails.application.routes.draw do
  def not_implemented
    -> (_) { [501, {}, []] }
  end

  get '/' => redirect('/en')

  get '/robots', to: 'sitemap#robots'

  scope '/:locale', locale: /en|cy/ do
    root 'home#show'

    resource :cookies_disabled

    #Money Navigator Tool
    scope :tools do
      scope '/:money_navigator_tool', money_navigator_tool: /money-navigator-tool|teclyn-llywio-ariannol/ do
        get '/', to: 'money_navigator_tool#landing'
        get '/questionnaire', to: 'money_navigator_tool#questionnaire', as: 'money_navigator_tool_questionnaire'
        post '/questionnaire', to: 'money_navigator_tool#questionnaire'
        patch '/questionnaire', to: 'money_navigator_tool#questionnaire'
        get '/results', to: 'money_navigator_tool#results', as: 'money_navigator_tool_results'
      end
    end

    get '/sitemap', to: 'sitemap#index'

    devise_for :users,
               only: [:registrations, :sessions, :passwords],
               controllers: {
                 registrations: 'registrations',
                 sessions: 'sessions',
                 passwords: 'passwords'
               }

    scope '/users' do
      resource :profile, only: [:edit, :update], controller: :profile
    end

    mount Agreements::Engine => '/:tool_id',
          constraints: ToolMountPoint.for(:agreements)

    mount AdvicePlans::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:advice_plans)

    mount ActionPlans::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:action_plans)

    mount CostCalculatorBuilder::Engine => '/:engine_id',
          constraints: EngineMountPoint.for(:cost_calculator_builder)

    bpmp = ToolMountPoint.for(:budget_planner)
    budget_planner_url_constraint = /#{bpmp.en_id}|#{bpmp.cy_id}/
    mount BudgetPlanner::Engine => '/tools/:tool_id(/:incognito)',
          constraints: { tool_id: budget_planner_url_constraint, incognito: /incognito/ }

    mount CarCostTool::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:car_cost_tool)

    mount CutbackCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:cutback_calculator)

    mount DebtAndMentalHealth::Engine => '/:tool_id',
          constraints: ToolMountPoint.for(:debt_and_mental_health)

    mount DebtFreeDayCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:debt_free_day_calculator)

    mount DebtAdviceLocator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:debt_advice_locator)

    mount DebtTest::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:debt_test)

    mount DecisionTrees::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:decision_trees)

    mount Feedback::Engine => '/improvements'

    mount MortgageCalculator::Engine => '/tools/:tool_id',
          constraints: { tool_id: %r{mortgage-calculator|cyfrifiannell-morgais|house-buying|prynu-ty} }

    mount Pacs::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:pacs)

    mount PaydayLoansIntervention::Engine => '/:tool_id',
          constraints: ToolMountPoint.for(:payday_loans)

    mount PensionsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:pensions_calculator)

    mount Quiz::Engine => '/tools/:tool_id',
      constraints: ToolMountPoint.for(:quiz)

    mount UniversalCredit::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:universal_credit)

    mount SavingsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:savings_calculator)

    mount Timelines::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:timelines)

    mount Wpcc::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:wpcc)

    get LandingPagePaths.path(:retirements, :index, :en),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :index, :cy),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :budgeting, :en), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :budgeting, :cy), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :en), to: 'retirements#pension_savings_timeline'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :cy), to: 'retirements#pension_savings_timeline'

    get '/tools/:id', to: 'landing_pages#show', constraints: { id: /annuities/ }

    get '/tools/redirect_to/:tool_name', to: 'redirectors#redirect'

    resources :articles, only: 'show' do
      resource :amp, only: [:show], controller: :amp_articles
      resources :page_feedbacks, only: [:create]
      patch 'page_feedbacks' => 'page_feedbacks#update'
    end

    get '/:page_type/:id/preview' => 'articles_preview#show',
        page_type: /articles|corporate|tools/

    get '/:page_type/:id/preview' => 'videos_preview#show',
        page_type: /videos/

    get '/:page_type/:id/preview' => 'home_pages_preview#show',
        page_type: /home_pages/

    resources :categories, only: 'show'
    resources :search_results, only: 'index', path: 'search'
    resources :videos, only: :show

    resources :corporate_categories, only: [:show], constraints: CorporateCategoriesConstraint.new
    resources :corporate, only: [:index, :show, :create] do
      get 'export-partners', on: :collection
    end

    resources :corporate, only: [:show], as: 'corporate_articles'

    resources :campaigns,
              only: 'show',
              path: 'campaigns',
              constraints: {
                id: %r{
                      coping-with-unexpected-bills|
                      how-to-look-ahead-when-buying-a-car|
                      revealed-the-true-cost-of-buying-a-car|
                      the-cost-of-caring
                    }x
              }

    get '/tools/christmas-money-planner', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'en' }
    get '/tools/cynllunydd-ariannol-y-nadolig', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'cy' }

    get '/campaigns/debt-management', to: 'debt_management#show'
    get '/campaigns/debt-management/faq', to: 'debt_management#faq'

    # Employer best practice
    get '/employer-best-practices', to: 'employer_best_practices#show'
    get '/employer-best-practices/faq', to: 'employer_best_practices#faq'
    get '/employer-best-practices/help', to: 'employer_best_practices#help'
    get '/employer-best-practices/money-guide', to: 'employer_best_practices#money_guide'
    get '/employer-best-practices/my-business', to: 'employer_best_practices#my_business'
    get '/employer-best-practices/other-employers', to: 'employer_best_practices#other_employers'

    # PACE
    # NB online route handles redirection to the external_urls (see PACE controller)
    # Some services point directly to it so it is still required
    get '/moneyadvisernetwork', to: 'pace#show'
    get '/moneyadvisernetwork/privacy', to: 'pace#privacy'
    get '/moneyadvisernetwork/online', to: 'pace#online'

    resource :feedback, only: [:new, :create], controller: :technical_feedback, as: :technical_feedback

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'

    resource :cookie_dismissal, only: :create, controller: 'cookie_dismissal'

    resource :empty, only: :show, controller: :empty

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
          get 'pages_campaign', path: '/campaign'
          get 'pages_technical_feedback', path: '/technical_feedback'
          get 'pages_error', path: '/error'
          get 'pages_news_article', path: '/news_article'
          get 'pages_action_plan', path: '/action_plan'
          get 'pages_news_index', path: '/news_index'
          get 'pages_home', path: '/home'
          get 'pages_search_results', path: '/search_results'
          get 'pages_parent_category_page', path: '/parent_category_page'
          get 'pages_child_category_page', path: '/child_category_page'
          get 'pages_annuities_landing_page', path: '/annuities_landing_page'
          get 'pages_contact', path: '/contact'
          get 'pages_tool', path: '/tool'
        end

        scope 'css' do
          get 'css_overview', path: '/'
          get 'css_basic', path: '/typography'
          get 'css_article_demo', path: '/article-demo'
          get 'css_default_styles', path: '/default-styles'
        end

      end
    end

    get '/hub/coronavirus-support', to: redirect('/en/hub/coronavirus-money-guidance')
    get '/hub/cymorth-coronafeirws', to: redirect('/cy/hub/arweiniad-ariannol-coronafeirws')
    get '/hub/:slug' => 'content_hub#show', as: :content_hub
  end

  %w(422 500 ).each do |status_code|
    get status_code, to: 'errors#show', status_code: status_code
  end

  scope '/:locale', locale: /en|cy/ do
    match '*path', via: :all, to: 'catchall#not_implemented'
  end
  match '*path', via: :all, to: 'catchall#not_implemented'
end
