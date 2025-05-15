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
    get '/direct/budget-planner', to: 'direct_budget_planner#new'

    get '/tools/car-costs-calculator', to: 'car_cost_tool#index'
    get '/tools/car-costs-calculator/*all', to: 'car_cost_tool#index'
    get '/tools/money-navigator-tool', to: 'money_navigator_tool#index'
    get '/tools/money-navigator-tool/*all', to: 'money_navigator_tool#index'
    get '/tools/money-manager', to: 'money_manager_tool#index'
    get '/tools/money-manager/*all', to: 'money_manager_tool#index'

    resource :cookies_disabled

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

    bpmp = ToolMountPoint.for(:budget_planner)
    budget_planner_url_constraint = /#{bpmp.en_id}|#{bpmp.cy_id}/
    mount BudgetPlanner::Engine => '/tools/:tool_id(/:incognito)',
          constraints: { tool_id: budget_planner_url_constraint, incognito: /incognito/ }

    mount CutbackCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:cutback_calculator)

    mount DebtAndMentalHealth::Engine => '/:tool_id',
          constraints: ToolMountPoint.for(:debt_and_mental_health)

    mount DebtFreeDayCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:debt_free_day_calculator)

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

    mount SavingsCalculator::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:savings_calculator)

    mount Wpcc::Engine => '/tools/:tool_id',
          constraints: ToolMountPoint.for(:wpcc)

    get LandingPagePaths.path(:retirements, :index, :en),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :index, :cy),     to: 'retirements#index'
    get LandingPagePaths.path(:retirements, :budgeting, :en), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :budgeting, :cy), to: 'retirements#budgeting'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :en), to: 'retirements#pension_savings_timeline'
    get LandingPagePaths.path(:retirements, :pension_savings_timeline, :cy), to: 'retirements#pension_savings_timeline'

    get '/tools/:id', to: 'landing_pages#show', constraints: { id: /annuities/ }

    get '/tools/christmas-money-planner', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'en' }
    get '/tools/cynllunydd-ariannol-y-nadolig', to: 'christmas_money_planner#show', constraints: lambda { |request| request.params['locale'] == 'cy' }

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

    resource :cookie_notice_acceptance, only: :create, path: 'cookie-notice'

    resource :cookie_dismissal, only: :create, controller: 'cookie_dismissal'

    resource :empty, only: :show, controller: :empty

    get '/hub/coronavirus-support', to: redirect('/en/hub/coronavirus-money-guidance')
    get '/hub/cymorth-coronafeirws', to: redirect('/cy/hub/arweiniad-ariannol-coronafeirws')
    get '/hub/:slug' => 'content_hub#show', as: :content_hub
  end

  %w(422 500).each do |status_code|
    get status_code, to: 'errors#show', status_code: status_code
  end

  scope '/:locale', locale: /en|cy/ do
    match '*path', via: :all, to: 'catchall#not_implemented'
  end
  match '*path', via: :all, to: 'catchall#not_implemented'
end
