require_relative '../../features/support/ui/pages/sign_in'
require_relative '../../features/support/ui/pages/forgot_password'
require_relative '../../features/support/ui/pages/change_password'

require 'email_spec'

RSpec.describe 'password reset', type: :feature do
  include EmailSpec::Helpers

  let(:sign_in_page) { UI::Pages::SignIn.new }
  let(:forgot_password_page) { UI::Pages::ForgotPassword.new }
  let(:change_password_page) { UI::Pages::ChangePassword.new }

  before do
    @old_url = ENV['MONEY_HELPER_URL']
    ENV['MONEY_HELPER_URL'] = 'https://www.moneyhelper.org.uk'
  end
  after { ENV['MONEY_HELPER_URL'] = @old_url }

  it 'allows me to reset my password' do
    redirect_reader = double(:redirect_reader)
    allow(Core::RedirectReader).to receive(:new).and_return(redirect_reader)
    allow(redirect_reader).to receive(:call)

    user = create(:user)

    sign_in_page.load(locale: 'en')
    sign_in_page.forgot_password.click
    forgot_password_page.email.set user.email
    forgot_password_page.submit.click

    expect(page.html).to include(
      I18n.t('devise.passwords.send_instructions', locale: 'en')
    )

    email = unread_emails_for(user.email).first
    open_email(user.email)
    expect(current_email.default_part_body.to_s).to include(
      'Change my password'
    )

    visit_in_email('Change my password', user.email)

    change_password_page.password.set 'securePassword'
    change_password_page.password_confirmation.set 'securePassword'

    allow_any_instance_of(PasswordsController).to receive(
      :redirect_to
    ) do |instance, url|
      expect(url).to eq('https://www.moneyhelper.org.uk/en/users/my-profile')
      instance.render text: 'redirected'
    end
    change_password_page.submit.click
  end
end
