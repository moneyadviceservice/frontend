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
end
