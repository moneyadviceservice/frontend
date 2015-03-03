RSpec.describe CorporateDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(content_item) }

  let(:content_item) { instance_double(Core::Article, id: 'bob', slug: 'syndicated') }

  describe '#extra_content?' do
    let(:lookup_context) { double }

    before do
      expect(decorator).to receive(:lookup_context).and_return(lookup_context)
    end

    context 'when article has partial' do
      before do
        expect(lookup_context).to receive(:template_exists?)
          .with('syndicated', ['corporate/extra'], true)
          .and_return(true)
      end

      it 'returns true' do
        expect(decorator.extra_content?).to be true
      end
    end

    context 'when articles does not have partial' do
      before do
        expect(lookup_context).to receive(:template_exists?)
          .with('syndicated', ['corporate/extra'], true)
          .and_return(false)
      end

      it 'returns false' do
        expect(decorator.extra_content?).to be false
      end
    end
  end

  describe '#extra_content_partial' do
    it 'returns the corporate extra content path' do
      expect(decorator.extra_content_partial).to eq('corporate/extra/syndicated')
    end
  end
end
