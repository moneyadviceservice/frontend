require_relative './shared_examples/displays_banner_warning.rb'

RSpec.describe BudgetWarning, type: :helper do
  context '#before announcement day' do
    it 'should not display banner warning' do
      Timecop.freeze(Chronic.parse('3rd March 2016')) do
        expect(described_class.display_banner_warning?).to be(false)
      end
    end
  end

  context '#on announcement day' do
    it_behaves_like 'displays_warning_banner' do
      let(:date) { '16th March 2016' }
    end
  end

  context '#after announcement day' do
    it_behaves_like 'displays_warning_banner' do
      let(:date) { '24th March 2016' }
    end
  end

  describe '#whitelisted page' do
    context 'english pages' do
      it 'displays banner for only the Redundancy Calculator' do
        request = double('request', url: 'www.example.com/en/tools/redundancy-pay-calculator/',
                                    base_url: 'www.example.com')
        allow(BudgetWarning).to receive(:request).and_return(request)

        expect(described_class.whitelisted?).to be(true)
      end
    end
    context 'welsh pages' do
      it 'displays banner for only the Redundancy Calculator' do
        request = double('request', url: 'www.example.com/cy/tools/cyfrifiannell-tal-diswyddo/',
                                    base_url: 'www.example.com')
        allow(BudgetWarning).to receive(:request).and_return(request)

        expect(described_class.whitelisted?).to be(true)
      end
    end
  end
end


