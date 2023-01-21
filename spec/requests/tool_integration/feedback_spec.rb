RSpec.describe 'Feedback', type: :request do
  %w[
    /en/improvements
  ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_redirect }
    end
  end
end
