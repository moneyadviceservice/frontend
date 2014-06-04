RSpec.describe 'HTML validation', :type => :feature do
  describe 'home page' do
    before { visit root_path(locale: locale) }

    context 'in English' do
      let(:locale) { 'en' }

      specify { expect(page).to have_valid_html }
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

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

  describe 'search results' do
    context 'in English' do
      let(:locale) { 'en' }

      context 'with no query' do
        before { visit search_results_path(locale: locale) }
        specify { expect(page).to have_valid_html }
      end

      context 'with no results' do
        before { visit search_results_path(query: 'Foobar', locale: locale) }
        specify { expect(page).to have_valid_html }
      end

      context 'with results' do
        before do
          visit search_results_path(query:  'How to budget for a monthly benefit payment',
                                    locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

      context('with no query') do
        before { visit search_results_path(locale: locale) }
        specify { expect(page).to have_valid_html }
      end

      context 'with no results' do
        before { visit search_results_path(query: 'Foobar', locale: locale) }
        specify { expect(page).to have_valid_html }
      end

      context 'with results' do
        before do
          visit search_results_path(query:  'Sut i gyllidebu ar gyfer taliad budd-daliadau misol',
                                    locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end
    end
  end
end
