RSpec.describe 'shared/_authentication', :type => :view do
  let(:logged_in) { false }

  before do
    allow(controller).to receive(:default_url_options) do
      { locale: I18n.default_locale }
    end

    allow(view).to receive(:user_signed_in?) { logged_in }
    allow(view).to receive(:display_search_box_in_header?)

    render
  end

  context 'when the user is not signed in' do
    specify { expect(rendered).to include(t('authentication.sign_in')) }
    specify { expect(rendered).to_not include(t('authentication.sign_out')) }
    specify { expect(rendered).to include(t('authentication.register')) }
    specify { expect(rendered).to_not include(t('authentication.my_account')) }
  end

  context 'when the user is signed in' do
    let(:logged_in) { true }

    specify { expect(rendered).to_not include(t('authentication.sign_in')) }
    specify { expect(rendered).to include(t('authentication.sign_out')) }
    specify { expect(rendered).to_not include(t('authentication.register')) }
    specify { expect(rendered).to include(t('authentication.my_account')) }
  end
end
