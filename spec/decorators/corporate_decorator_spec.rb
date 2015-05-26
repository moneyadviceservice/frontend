RSpec.describe CorporateDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(content_item) }

  let(:content_item)             { instance_double(Core::Article, id: 'bob', slug: 'article_with_dynamic_partial') }
  let(:corporate_tool_directory) { instance_double(Core::Article, id: 'rob', slug: 'syndication') }
  let(:corporate_tool_page)      { instance_double(Core::Article, id: 'job', slug: 'sample-tool-syndication') }

  describe '#extra_content?' do
    let(:lookup_context) { double }

    before do
      expect(decorator).to receive(:lookup_context).and_return(lookup_context)
    end

    context 'when article has partial' do
      before do
        expect(lookup_context).to receive(:template_exists?)
          .with('article_with_dynamic_partial', ['corporate/extra'], true)
          .and_return(true)
      end

      it 'returns true' do
        expect(decorator.extra_content?).to be true
      end
    end

    context 'when articles does not have partial' do
      before do
        expect(lookup_context).to receive(:template_exists?)
          .with('article_with_dynamic_partial', ['corporate/extra'], true)
          .and_return(false)
      end

      it 'returns false' do
        expect(decorator.extra_content?).to be false
      end
    end
  end

  describe '#extra_content_partial' do

    context 'for articles with partials' do
      it 'returns the corporate extra content path' do
        expect(decorator.extra_content_partial).to eq('corporate/extra/article_with_dynamic_partial')
      end
    end

    context 'for the corporate tool directory article' do
      subject(:decorator) { described_class.decorate(corporate_tool_directory) }

      it 'returns the corporate extra content syndication path' do
        expect(decorator.extra_content_partial).to eq('corporate/extra/syndication')
      end
    end

    context 'for a corporate tool page article' do
      subject(:decorator) { described_class.decorate(corporate_tool_page) }

      it 'returns the corporate extra content tool path' do
        expect(decorator.extra_content_partial).to eq('corporate/extra/tool')
      end
    end
  end
end
