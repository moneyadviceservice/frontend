RSpec.describe ApplicationHelper, type: :helper do
  describe '#hide_sticky_header?' do
    before do
      expect(helper).to receive(:request).and_return(request)
    end

    context 'when tools request' do
      let(:request) { double(fullpath: '/en/tools/mortgage-calculator') }

      it 'returns true' do
        expect(helper.hide_sticky_header?).to be true
      end
    end

    context 'when retirement income options' do
      let(:request) { double(fullpath: '/en/retirement-income-options/income-drawdown') }

      it 'returns true' do
        expect(helper.hide_sticky_header?).to be true
      end
    end

    context 'when non tools request' do
      let(:request) { double(fullpath: '/en') }

      it 'returns false' do
        expect(helper.hide_sticky_header?).to be false
      end
    end
  end

  describe 'include_adobe_analytics_scripts?' do
    before do
      ENV['INCLUDE_AEM_ANALYTICS'] = 'true'
      allow(Rails).to receive(:env) { 'production'.inquiry }
    end

    context 'when the host is incorrect' do
      it 'returns false' do
        req = double(original_url: 'https://partner-tools.moneyadviceservice.org.uk/en/tools/meh')

        expect(helper.include_adobe_analytics_scripts?(req)).to be false
      end
    end

    context 'when the host is correct' do
      it 'returns true' do
        req = double(original_url: 'https://partner-tools.moneyhelper.org.uk/en/tools/meh')

        expect(helper.include_adobe_analytics_scripts?(req)).to be true
      end
    end
  end
end
