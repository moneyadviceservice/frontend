RSpec.describe 'HTML validation', type: :feature do
  describe 'home page' do
    context 'in English' do
      let(:locale) { 'en' }

      before do
        visit root_path(locale: locale)
      end

      specify { expect(page).to have_valid_html }
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

      before do
        visit root_path(locale: locale)
      end

      specify { expect(page).to have_valid_html }
    end
  end

  describe 'category pages' do
    before { visit category_path('saving-and-investing', locale: locale) }

    context 'in English' do
      let(:locale) { 'en' }

      specify { expect(page).to have_valid_html }
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

      specify { expect(page).to have_valid_html }
    end
  end

  describe 'article pages' do
    context 'in English' do
      before { visit article_path('why-save-into-a-pension', locale: 'en') }
      specify { expect(page).to have_valid_html }
    end

    context 'in Welsh' do
      before { visit article_path('pam-cynilo-mewn-pensiwn', locale: 'cy') }
      specify { expect(page).to have_valid_html }
    end
  end

end
