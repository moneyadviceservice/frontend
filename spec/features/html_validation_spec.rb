require 'spec_helper'

describe 'html validation' do
  describe 'home page' do
    before do
      visit root_path(locale: locale)
    end

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
    let(:category) { build :category_hash, :content_items }
    let(:repository) { Core::Repositories::Categories::Fake.new(category) }

    before do
      Core::Registries::Repository[:category] = repository
      visit category_path(category['id'], locale: locale)
    end

    context 'in English' do
      let(:locale) { 'en' }

      specify { expect(page).to have_valid_html }
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

      specify { expect(page).to have_valid_html }
    end
  end
end
