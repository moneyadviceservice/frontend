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

    if Feature.active?(:improvements)
      mount Feedback::Engine => '/improvements'
    end

    devise_for :users,
               only: [:registrations, :sessions, :passwords],
               controllers: {
                 registrations: 'registrations',
                 sessions: 'sessions',
                 passwords: 'passwords'
               }

    if Feature.active?(:profile)
      scope '/users' do
        resource :profile, only: [:edit, :update], controller: :profile
      end
    end

    Feature.with(:cost_calculator_builder) do
      mount CostCalculatorBuilder::Engine => '/:engine_id',
            constraints: EngineMountPoint.for(:cost_calculator_builder)
    end

    Feature.with(:budget_planner) do
      bpmp = ToolMountPoint.for(:budget_planner)
      budget_planner_url_constraint = /#{bpmp.en_id}|#{bpmp.cy_id}/

      mount BudgetPlanner::Engine => '/tools/:tool_id(/:incognito)',
            constraints: { tool_id: budget_planner_url_constraint, incognito: /incognito/ }
    end

    Feature.with(:baby_cost_calculator) do
      mount BabyCostCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:baby_cost_calculator)
    end

    Feature.with(:car_cost_tool) do
      mount CarCostTool::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:car_cost_tool)
    end

    Feature.with(:action_plans) do
      mount ActionPlans::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:action_plans)
    end

    Feature.with(:contribution_calculator) do
      mount ContributionCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:contribution_calculator)
    end

    Feature.with(:cutback_calculator) do
      mount CutbackCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:cutback_calculator)
    end

    Feature.with(:debt_and_mental_health) do
      mount DebtAndMentalHealth::Engine => '/:tool_id',
            constraints: ToolMountPoint.for(:debt_and_mental_health)
    end

    Feature.with(:debt_free_day_calculator) do
      mount DebtFreeDayCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:debt_free_day_calculator)
    end

    Feature.with(:debt_advice_locator) do
      mount DebtAdviceLocator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:debt_advice_locator)
    end

    Feature.with(:debt_test) do
      mount DebtTest::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:debt_test)
    end

    Feature.with(:health_check) do
      mount AdvicePlans::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:advice_plans)

      mount DecisionTrees::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:decision_trees)
    end

    Feature.with(:mortgage_calculator) do
      mount MortgageCalculator::Engine => '/tools/:tool_id',
            constraints: { tool_id: %r{mortgage-calculator|cyfrifiannell-morgais|house-buying|prynu-ty} }
    end

    Feature.with(:payday_loans) do
      mount PaydayLoansIntervention::Engine => '/:tool_id',
            constraints: ToolMountPoint.for(:payday_loans)
    end

    mount PensionsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:pensions_calculator)

    Feature.with(:rio) do
      mount Rio::Engine => '/:engine_id',
            constraints: EngineMountPoint.for(:rio)
    end

    Feature.with(:pensions_and_retirement) do
      get LandingPagePaths.path(:retirements, :index, :en),     to: 'retirements#index'
      get LandingPagePaths.path(:retirements, :index, :cy),     to: 'retirements#index'
      get LandingPagePaths.path(:retirements, :budgeting, :en), to: 'retirements#budgeting'
      get LandingPagePaths.path(:retirements, :budgeting, :cy), to: 'retirements#budgeting'
    end

    Feature.with(:savings_calculator) do
      mount SavingsCalculator::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:savings_calculator)
    end

    Feature.with(:annuities_landing_page) do
      get '/tools/:id', to: 'landing_pages#show', constraints: { id: /annuities/ }
    end

    Feature.with(:timelines) do
      mount Timelines::Engine => '/tools/:tool_id',
            constraints: ToolMountPoint.for(:timelines)
    end

    if Feature.active?(:agreements)
      mount Agreements::Engine => '/agreements'
    end

    resources :action_plans, only: 'show'
    resources :articles, only: 'show' do
      resource :feedback, only: [:new, :create], controller: :article_feedbacks
    end

    get '/:page_type/:id/preview' => 'articles_preview#show',
        page_type: /articles|action_plans|news|videos|corporate|tools/

    resources :categories, only: 'show'
    resources :search_results, only: 'index', path: 'search'
    resources :news, only: [:show, :index]
    resource :advice, only: :show
    resources :videos, only: :show

    get '/corporate/contact-us', controller: 'static_pages',
                                 action: 'show',
                                 id: 'contact-us',
                                 constraints: { locale: 'en' }

    get '/corporate/cysylltu-a-ni', controller: 'static_pages',
                                    action: 'show',
                                    id: 'cysylltu-a-ni',
                                    constraints: { locale: 'cy' }

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
                      interest-rates-rise|
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
    get '/campaigns/debt-management/companies', to: 'debt_management#companies'

    resources :static_pages,
              path:        'static',
              only:        'show',
              constraints: { id: %r{contact-us|cysylltu-a-ni} }

    resource :feedback, only: [:new, :create], controller: :technical_feedback, as: :technical_feedback

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'

    resource :newsletter_subscription, only: :create, path: 'newsletter-subscription'

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
          get 'pages_feedback_information', path: '/feedback_information'
          get 'pages_feedback_technical', path: '/feedback_technical'
          get 'pages_feedback_advice', path: '/feedback_advice'
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
  end

  if Feature.active?(:redirects)
    match '*path', via: :all, to: 'catchall#not_implemented'
  else
    match '*path', via: :all, to: not_implemented
  end
end
