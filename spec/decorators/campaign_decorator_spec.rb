RSpec.describe CampaignDecorator do
  subject(:decorator) { described_class.decorate(campaign) }

  let(:name) { 'test-name' }
  let(:campaign) { Campaign.new(name: name) }

  describe '#footer_alternate_options' do
    subject { decorator.footer_alternate_options }

    context "when locale is 'en'" do
      let(:alternate_path) { '/alternate_path' }

      before { allow(helper).to receive(:campaign_path) { alternate_path } }

      it { is_expected.to eq('cy' => alternate_path) }
    end

    context "when locale is 'cy'" do
      let(:path) { '/path' }

      before do
        I18n.locale = :cy
        allow(helper).to receive(:campaign_path) { path }
      end

      it { is_expected.to eq('en' => path) }
    end
  end
end
