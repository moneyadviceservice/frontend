RSpec.describe 'shared/_footer', type: :view do

  before do
    controller.extend(Localisation)
    allow(view).to receive(:hide_contact_panels?) { false } 
    allow(view).to receive(:user_signed_in?) { false }
    allow(view).to receive(:cookies_not_accepted?) { false }
    allow(view).to receive(:alternate_locales) { [] }
    allow(view).to receive(:hide_elements_irrelevant_for_third_parties?) { true }
  end

  it 'has a link to email moneyadviceservice if there are accessibility issues' do
    render
    expect(rendered).to include(t('footer_secondary.title'))
    expect(rendered).to include('href="mailto:accessibility@moneyadviceservice.org.uk"')
  end

  it 'does not include the Accessin image' do
    render
    expect(rendered).to_not include('class="icon icon--accessibility"')
  end
end