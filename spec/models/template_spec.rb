require 'campaign_page/campaign'
require 'campaign_page/section'
require 'campaign_page/article'

RSpec.describe Template do
  let(:id) { 'revealed-the-true-cost-of-buying-a-car' }

  subject(:template) do
    described_class.new(path: Rails.root.join('spec', 'fixtures', 'campaigns'))
  end

  describe '#build_campaign' do
    subject(:plan) { template.build_campaign(id) }

    it { is_expected.to be_an_instance_of(CampaignPage::Campaign) }

    context 'when template is not found' do
      let(:id) { 'fake-id' }

      it 'raise an exception' do
        expect { plan }.to raise_error(Template::TemplateNotFound)
      end
    end

    it 'has sections' do
      expect(plan.sections).to_not be_empty
    end
  end
end
