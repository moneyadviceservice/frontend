RSpec.feature 'Budget Planner' do
  scenario 'The `noresize` param when set, persists across requests' do
    allow_any_instance_of(ApplicationController).to receive(:syndicated_tool_request?).and_return(true)

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
end
