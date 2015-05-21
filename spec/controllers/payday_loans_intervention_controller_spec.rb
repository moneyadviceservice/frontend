RSpec.describe PaydayLoansInterventionController, type: :controller do
  describe '#alternate_url' do
    before do
      allow(controller).to receive(:params).and_return(params)
    end

    context 'when current locale is english' do
      let(:params) { { locale: 'en', tool_id: 'payday-loans' } }

      it 'returns the welsh url' do
        expect(controller.alternate_url).to eq('/cy/benthyciadau-diwrnod-cyflog')
      end
    end

    context 'when current locale is welsh' do
      let(:params) { { locale: 'cy', tool_id: 'benthyciadau-diwrnod-cyflog' } }

      it 'returns the welsh url' do
        expect(controller.alternate_url).to eq('/en/payday-loans')
      end
    end
  end
end
