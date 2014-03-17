require 'spec_helper'

Dir[File.join(File.dirname(__FILE__), '..', '..', 'lib', 'core', 'entities', '*')].each do |entity|
  require entity
end

describe CategoryContentDecorator do
  include Draper::ViewHelpers

  let(:item) { Object.new }
  let(:locale) { 'en' }

  before { allow(I18n).to receive(:locale) { locale } }

  subject(:decorator) { described_class.decorate(item) }

  it { should respond_to(:id) }
  it { should respond_to(:path) }
  it { should respond_to(:title) }
  it { should respond_to(:contents) }
  it { should respond_to(:description) }
  it { should respond_to(:type) }

  describe '#path' do
    context 'with a Category' do
      let(:item) { build :category }

      it 'calls the correct path helper' do
        expect(helpers).to receive(:category_path).with(item.id, locale: locale)
        subject.path
      end
    end

    context 'with an Article' do
      let(:item) { build :article }

      it 'calls the correct path helper' do
        expect(helpers).to receive(:article_path).with(item.id, locale: locale)
        subject.path
      end
    end

    context 'with an ActionPlan' do
      let(:item) { build :action_plan }

      it 'calls the correct path helper' do
        expect(helpers).to receive(:action_plan_path).with(item.id, locale: locale)
        subject.path
      end
    end

    context 'with an Other' do
      let(:item) { Core::Other.new('item-id') }

      it 'returns the correct path' do
        ['campaign', 'news', 'tool', 'video'].each do |type|
          item.stub(type: type)
          expect(subject.path).to eq "/#{locale}/#{type.pluralize}/#{item.id}"
        end
      end
    end
  end
end
