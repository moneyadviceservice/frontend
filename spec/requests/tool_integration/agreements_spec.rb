RSpec.describe 'Feedback', type: :request do
  %w(
    /en/agreements/debt_evaluation_toolkit/new
    /en/agreements/partners/new
    /en/agreements/indebted_lives_report/new
    /cy/agreements/debt_evaluation_toolkit/new
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
