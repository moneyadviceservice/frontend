require 'spec_helper'
require 'core/entities/search_result'

describe SearchResultDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(search_result) }

  let(:search_result) do
    double(Core::SearchResult, id: 'item-id', title: double, description: double)
  end

  it { should respond_to(:path) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }

  describe '#path' do
    let(:locale) { 'en' }
    before { allow(I18n).to receive(:locale) { locale } }

    %w{article guide}.each do |type|
      context "and it is of type '#{type}'" do
        before { allow(search_result).to receive(:type) { type } }

        it 'calls the article path helper' do
          expect(helpers).to receive(:article_path).with(search_result.id, locale: locale)
          subject.path
        end
      end
    end

    context "and it is of type 'action-plan'" do
      before { allow(search_result).to receive(:type) { 'action-plan' } }

      it 'calls the action_plan path helper' do
        expect(helpers).to receive(:action_plan_path).with(search_result.id, locale: locale)
        subject.path
      end
    end

    context "and it is of type 'category'" do
      before { allow(search_result).to receive(:type) { 'category' } }

      it 'calls the category path helper' do
        expect(helpers).to receive(:category_path).with(search_result.id, locale: locale)
        subject.path
      end
    end

    context "and is of the not yet supported type" do
      context "'campaign'" do
        before { allow(search_result).to receive(:type) { 'campaign' } }

        it 'returns the expected path' do
          expect(subject.path).to eq "/#{locale}/campaigns/#{search_result.id}"
        end
      end

      context "'news'" do
        before { allow(search_result).to receive(:type) { 'news' } }

        it 'returns the expected path' do
          expect(subject.path).to eq "/#{locale}/news/#{search_result.id}"
        end
      end

      context "'tool'" do
        before { allow(search_result).to receive(:type) { 'tool' } }

        it 'returns the expected path' do
          expect(subject.path).to eq "/#{locale}/tools/#{search_result.id}"
        end
      end

      context "'video'" do
        before { allow(search_result).to receive(:type) { 'video' } }

        it 'returns the expected path' do
          expect(subject.path).to eq "/#{locale}/videos/#{search_result.id}"
        end
      end
    end
  end
end
