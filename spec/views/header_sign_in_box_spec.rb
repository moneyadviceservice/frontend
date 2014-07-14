RSpec.describe 'shared/_sign_in_box', :type => :view do
  let(:logged_in) { false }

  before do
    allow(view).to receive(:user_signed_in?) { logged_in }
  end

  context 'when the user is not signed in' do
    it 'displays a sign in link' do
      render

      expect(rendered).to include(t('authentication.sign_in'))
    end
  end

  context 'when the user is signed in' do
    let(:logged_in) { true }

    it 'displays a sign out link' do
      render

      expect(rendered).to include(t('authentication.sign_out'))
    end
  end
end
