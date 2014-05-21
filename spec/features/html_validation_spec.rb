require 'spec_helper'
require 'core/interactors/article_reader'
require 'core/interactors/searcher'

describe 'HTML validation', :type => :feature do
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

  describe 'article pages' do
    let(:article) { build :article }
    let(:reader) { -> { article } }

    before do
      allow(Core::ArticleReader).to receive(:new).with(article.id).and_return(reader)
      visit article_path(article.id, locale: locale)
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

  describe 'search results' do
    let(:query) { 'what to do when someone dies' }
    let(:page_number) { 1 }
    let(:per_page) { 10 }
    let(:total_results) { 0 }
    let(:content_item) { build :article }
    let(:results) { [] }
    let(:result_collection) do
      double('search result collection',
        page: page_number,
        per_page: per_page,
        total_results: total_results,
        items: results)
    end
    let(:searcher) { -> { result_collection } }

    before do
      allow(Core::Searcher).to receive(:new).with(query, page: nil).and_return(searcher)
    end

    context 'in English' do
      let(:locale) { 'en' }

      context 'with no query' do
        before do
          visit main_app.search_results_path(locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end

      context 'with no results' do
        before do
          visit main_app.search_results_path(query: query, locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end

      context 'with results' do
        let(:total_results) { 1 }
        let(:results) { [content_item] }

        before do
          visit main_app.search_results_path(query: query, locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end
    end

    context 'in Welsh' do
      let(:locale) { 'cy' }

      context 'with no query' do
        before do
          visit main_app.search_results_path(locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end

      context 'with no results' do
        before do
          visit main_app.search_results_path(query: query, locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end

      context 'with results' do
        let(:total_results) { 1 }
        let(:results) { [content_item] }

        before do
          visit main_app.search_results_path(query: query, locale: locale)
        end

        specify { expect(page).to have_valid_html }
      end
    end
  end
end
