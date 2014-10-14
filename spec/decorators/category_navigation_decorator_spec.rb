RSpec.describe CategoryNavigationDecorator do
  include Draper::ViewHelpers

  let(:main_app_helper) { double }
  let(:item) { Object.new }

  subject(:decorator) { described_class.decorate(item) }

  before { allow(helpers).to receive(:main_app) { main_app_helper } }

  it { is_expected.to respond_to(:title) }
  it { is_expected.to respond_to(:path) }
  it { is_expected.to respond_to(:contents) }

  describe '#path' do
    let(:id) { 'expected-id' }
    let(:category) { build(:category, id: id) }
    let(:item) { double(id: double, content: category) }

    it 'calls to the correct path helper' do
      expect(main_app_helper).to receive(:category_path).with(id)

      subject.path
    end

    context 'when category is news' do
      let(:id) { 'news' }

      it 'calls to the correct path helper' do
        expect(main_app_helper).to receive(:url_for).with("/#{I18n.locale}/#{id}")

        subject.path
      end
    end
  end
end
