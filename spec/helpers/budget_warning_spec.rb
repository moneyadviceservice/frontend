require_relative './shared_examples/displays_banner_warning.rb'

RSpec.describe BudgetWarning, type: :helper do
  context '#before announcement day' do
    it 'should not display banner warning' do
      Timecop.freeze(Chronic.parse('3rd March 2017')) do
        expect(display_banner_warning?).to be(false)
      end
    end
  end

  context '#on announcement day' do
    it_behaves_like 'displays_warning_banner' do
      let(:date) { '6th April 2022' }
    end
  end

  context '#after announcement day' do
    it_behaves_like 'displays_warning_banner' do
      let(:date) { '24th April 2022' }
    end
  end

  describe '#whitelisted?' do
    let(:request) do
      double(
        url: 'example.org/en/tools/redundancy-pay-calculator/',
        base_url: 'example.org'
      )
    end

    before do
      stub_const('BudgetWarning::WHITELIST', whitelisted_tools)
      allow(helper).to receive(:request).and_return(request)
    end

    context 'when request is whitelisted' do
      let(:whitelisted_tools) do
        ['/en/tools/redundancy-pay-calculator/']
      end

      it 'returns true' do
        expect(helper).to be_whitelisted
      end
    end

    context 'when request is not whitelisted' do
      let(:whitelisted_tools) do
        ['/en/tools/budget-planner/']
      end

      it 'returns false' do
        expect(helper).to_not be_whitelisted
      end
    end
  end
end
