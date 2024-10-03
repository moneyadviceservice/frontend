require_relative '../../features/support/ui/pages/sign_in'

RSpec.feature 'Budget Planner' do
  scenario 'The `noresize` param when set, persists across requests' do
    visit '/en/tools/budget-planner?noresize=true'

    page.all('form').each do |form|
      expect(form['action']).to end_with('?noresize=true')
    end

    saved_link = page.find('a', text: 'Access your saved Budget Plan')

    expect(saved_link['href']).to end_with('?noresize=true')

    visit '/en/tools/budget-planner'

    page.all('form').each do |form|
      expect(form['action']).not_to end_with('?noresize=true')
    end
  end

  scenario 'Using the direct sign-in link successfully in English' do
    create_user_budget
    visit '/en/direct/budget-planner'
    sign_in_user

    expect(@page.current_path).to eq('/en/tools/budget-planner/budget/summary')
  end

  scenario 'Using the direct sign-in link successfully in Welsh' do
    create_user_budget
    visit '/cy/direct/budget-planner'
    sign_in_user

    expect(@page.current_path).to eq('/cy/tools/cynllunydd-cyllideb/budget/summary')
  end

  def create_user_budget
    @user = create(:user)

    @budget = BudgetPlanner::Budget.new
    @budget.data = BudgetPlanner::BudgetDataFactory.new.build('budget-planner')
    @budget.steps.first.categories.first.sources.first.value = 2000.0
    @budget.steps[1].categories[0].sources[0].value = 50.0
    @budget.user = @user
    @budget.save
  end

  def sign_in_user
    @page = UI::Pages::SignIn.new
    expect(@page).to be_displayed

    @page.email.set(@user.email)
    @page.password.set(@user.password)
    @page.submit.click
  end
end
