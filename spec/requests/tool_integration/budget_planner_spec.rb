RSpec.describe 'Budget Planner', type: :request do
  %W[/cy/tools/#{ToolMountPoint::BudgetPlanner::CY_ID}].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end


  it 'redirects from the legacy direct sign-in link successfully in English' do
    get '/en/direct/budget-planner'

    expect(response).to redirect_to('https://tools.moneyhelper.org.uk/en/budget-planner/income?isEmbedded=true')
  end

  it 'redirects from the legacy direct sign-in link successfully in Welsh' do
    get '/cy/direct/budget-planner'

    expect(response).to redirect_to('https://tools.moneyhelper.org.uk/cy/budget-planner/income?isEmbedded=true')
  end
end
