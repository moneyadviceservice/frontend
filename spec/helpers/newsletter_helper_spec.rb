RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end

RSpec.describe NewsletterHelper, '#display_newsletter_form?', type: :helper do
  describe 'display form' do
    subject { helper.display_newsletter_form? }

    context 'user is not signed in' do
      it { is_expected.to be_truthy }
    end
  end
end
