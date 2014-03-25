require 'spec_helper'
require 'core/entities/category'

describe CategoryDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(category) }

  let(:category) do
    double(Core::Category, id: double, title: double, description: double)
  end

  it { should respond_to(:path) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:contents) }
  it { should respond_to(:canonical_url) }
  it { should respond_to(:alternate_options) }

  describe '#alternate_options' do
    let(:locale) { double }
    let(:url) { double }

    before do
      I18n.stub(available_locales: [locale])
      helpers.stub(category_url: url)
    end

    it 'returns a hash of locale => url pairs' do
      expect(subject.alternate_options).to include("#{locale}-GB" => url)
    end
  end

  describe '#path' do
    before { helpers.stub(category_path: '/categories/test') }

    it 'returns the path to the category' do
      expect(subject.path).to eq('/categories/test')
    end
  end

  describe '#canonical_url' do
    before { helpers.stub(category_url: '/categories/bob') }

    it 'returns the path to the category' do
      expect(subject.canonical_url).to eq('/categories/bob')
    end
  end
end
