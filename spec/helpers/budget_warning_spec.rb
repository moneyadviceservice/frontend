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

  describe '#whitelisted pages' do
    context 'english pages non-tools' do
      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
         let(:url) { "www.example.com/en/retirement-income-options/" }
      end

      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
         let(:url) { "www.example.com/en/retirement-income-options/retirement-options" }
      end
    end

    context 'english tools' do
      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
        let(:url) { 'www.example.com/en/tools/redundancy-pay-calculator/' }
      end
    end

    context 'welsh tools' do
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_tools' do
        let(:url) { 'www.example.com/cy/tools/cyfrifiannell-tal-diswyddo/' }
      end
    end

    context 'welsh pages for non-tools' do
      # RIO - Retirement Income Options
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_nontools' do
        let(:url) { 'www.example.com/cy/opsiynau-incwm-ymddeoliad/' }
      end

      # RIO page(s) - Retirement Options
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_nontools' do
        let(:url) { 'www.example.com/cy/opsiynau-incwm-ymddeoliad/retirement-options' }
      end
    end
  end
end
