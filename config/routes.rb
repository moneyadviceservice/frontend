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

    mount BabyCostCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:baby_cost_calculator)

    mount CarCostTool::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:car_cost_tool)

    mount ContributionCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:contribution_calculator)

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

    mount PaydayLoansIntervention::Engine => '/:tool_id',
          constraints: ToolMountPoint.for(:payday_loans)

    mount PensionsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:pensions_calculator)

    mount Quiz::Engine => '/tools/:tool_id',
      constraints: ToolMountPoint.for(:quiz)

    mount Rio::Engine => '/:engine_id',
          constraints: EngineMountPoint.for(:rio)

    mount SavingsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:savings_calculator)

    mount Timelines::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:timelines)

    get LandingPagePaths.path(:retirements, :index, :en),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :index, :cy),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :budgeting, :en), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :budgeting, :cy), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :en), to: 'retirements#pension_savings_timeline'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :cy), to: 'retirements#pension_savings_timeline'

    get '/tools/:id', to: 'landing_pages#show', constraints: { id: /annuities/ }

    resources :action_plans, only: 'show'
    resources :articles, only: 'show' do
      if Feature.active?(:page_feedback)
        resources :page_feedbacks, only: [:create]
        patch 'page_feedbacks' => 'page_feedbacks#update'
      end
    end

    get '/:page_type/:id/preview' => 'articles_preview#show',
        page_type: /articles|action_plans|news|corporate|tools/

    get '/:page_type/:id/preview' => 'videos_preview#show',
        page_type: /videos/

    get '/:page_type/:id/preview' => 'home_pages_preview#show',
        page_type: /home_pages/

    resources :categories, only: 'show'
    resources :search_results, only: 'index', path: 'search'
    resources :news, only: [:show, :index]
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
                      borrowing-get-the-facts|
                      budgeting-to-get-through-january|
                      cmo|
                      coping-with-unexpected-bills|
                      csa|
                      free-debt-advice|
                      friends-life-lander|
                      get-set-for-summer|
                      how-to-look-ahead-when-buying-a-car|
                      interest-only-mortgages|
                      life-and-critical-illness|
                      paying-too-much-tax-on-savings|
                      revealed-the-true-cost-of-buying-a-car|
                      save-gbp3-a-day-for-emergencies|
                      saving-for-a-holiday|
                      start-living-your-life-free-of-debt|
                      student-budgeting|
                      sw-saving-and-debt|
                      the-cost-of-caring|
                      the-true-cost-of-affording-a-home|
                      the-true-cost-of-borrowing|
                      uk-money-habits-study|
                      what-does-ma-think|
                      young-peoples-money-regrets
                    }x
              }

    get '/tools/christmas-money-planner', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'en' }
    get '/tools/cynllunydd-ariannol-y-nadolig', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'cy' }

    get '/campaigns/debt-management', to: 'debt_management#show'
    get '/campaigns/debt-management/faq', to: 'debt_management#faq'

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

    get '/hub/:slug' => 'content_hub#show', as: :content_hub
  end

  %w(404 422 500 ).each do |status_code|
    get status_code, to: 'errors#show', status_code: status_code
  end

  match '*path', via: :all, to: 'catchall#not_implemented'
end
