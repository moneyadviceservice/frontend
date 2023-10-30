RSpec.describe SearchResultDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(search_result) }

  let(:title) { double }
  let(:description) { double }
  let(:search_result) do
    instance_double(
      SiteSearch::Result,
      link: 'item-id', title: title, description: description
    )
  end

  it { is_expected.to respond_to(:link) }
  it { is_expected.to respond_to(:description) }
  it { is_expected.to respond_to(:title) }

  describe '#description' do
    subject { decorator.description }

    context 'when description is present' do
      let(:description) do
        '<p>If you created your <b>budget</b> plan <br></p>'
      end

      before { allow(search_result).to receive(:description) { description } }

      it { is_expected.to eq('<p>If you created your <b>budget</b> plan </p>') }
    end

    context 'when description is blank' do
      let(:description) {}

      before { allow(search_result).to receive(:description) { description } }

      it 'returns empty' do
        expect(subject).to be_empty
      end
    end
  end
end
