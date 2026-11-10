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

  describe '#include_adobe_analytics_scripts?' do
    before { ENV['INCLUDE_AEM_ANALYTICS'] = 'true' }

    context 'when in production' do
      it 'returns true' do
        allow(Rails).to receive(:env) { 'production'.inquiry }

        expect(helper.include_adobe_analytics_scripts?).to be true
      end
    end

    context 'when outside of production' do
      it 'returns false' do
        expect(helper.include_adobe_analytics_scripts?).to be false
      end
    end
  end
end
