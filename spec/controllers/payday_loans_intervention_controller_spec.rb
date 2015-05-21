RSpec.describe PaydayLoansInterventionController, type: :controller do
  include Rails.application.routes.url_helpers
  describe '#base_alternate_url' do
    let(:expected_params) do
      HashWithIndifferentAccess.new(params)
    end

    before do
      allow(controller).to receive(:params).and_return(expected_params)
    end

    context 'when current locale is english' do
      let(:params) do
        {
          locale: 'en',
          tool_id: 'payday-loans',
          controller: 'payday_loans_intervention/start',
          action: 'show'
        }
      end

      it 'returns the welsh url' do
        expect(controller.base_alternate_url).to eq('/cy/benthyciadau-diwrnod-cyflog')
      end
    end

    context 'when current locale is welsh' do
      let(:params) do
        {
          locale: 'cy',
          tool_id: 'benthyciadau-diwrnod-cyflog',
          controller: 'payday_loans_intervention/start',
          action: 'show'
        }
      end

      it 'returns the welsh url' do
        expect(controller.base_alternate_url).to eq('/en/payday-loans')
      end
    end

    context 'when current locale is english with the requested path' do
      let(:params) do
        {
          locale: 'cy',
          tool_id: 'benthyciadau-diwrnod-cyflog',
          action: 'show',
          controller: 'payday_loans_intervention/existing_pdls'
        }
      end

      it 'returns the welsh url' do
        expect(controller.base_alternate_url).to eq('/en/payday-loans')
      end
    end
  end
end
