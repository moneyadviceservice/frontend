RSpec.describe 'Feedback', type: :request do
  %w(
    /en/improvements
    /cy/improvements
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
