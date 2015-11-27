RSpec.describe 'Mortgage Calculator', type: :request do
  %w(
    /en/tools/mortgage-calculator
    /cy/tools/cyfrifiannell-morgais
    /en/tools/house-buying/mortgage-affordability-calculator
    /cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais
    /en/tools/house-buying/stamp-duty-calculator
    /cy/tools/prynu-ty/cyfrifiannell-treth-stamp
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
