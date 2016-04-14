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
    context 'english page for tools' do
      ['redundancy-pay-calculator',
        'workplace-pension-contribution-calculator',
        'pension-calculator'].each do |tool_name|
            it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
               let(:url) { "www.example.com/en/tools/#{tool_name}/" }
            end
      end
    end
  end

  describe '#whitelisted pages' do
    context 'english pages non-tools' do
      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
         let(:url) { "www.example.com/en/retirement-income-options/" }
      end

      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
         let(:url) { "www.example.com/en/retirement-income-options/income-drawdown" }
      end

      it_behaves_like 'displays_banner_warning_for_whitelisted_tools' do
         let(:url) { "www.example.com/en/retirement-income-options/retirement-options" }
      end
    end

    context 'welsh pages for tools' do
       ['cyfrifiannell-tal-diswyddo',
        'cyfrifiannell-cyfraniadau-pensiwn-gweithle',
        'cyfrifiannell-pensiwn'].each do |tool_name|
         describe tool_name do
           it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_tools' do
             let(:url)      { "www.example.com/cy/tools/#{tool_name}/" }
           end
         end
       end
    end

    context 'welsh pages for non-tools' do
      # RIO - Retirement Income Options
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_nontools' do
        let(:url) { 'www.example.com/cy/opsiynau-incwm-ymddeoliad/' }
      end

      # RIO page(s) - Income Drawdown
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_nontools' do
        let(:url) { 'www.example.com/cy/opsiynau-incwm-ymddeoliad/income-drawdown' }
      end

      # RIO page(s) - Retirement Options
      it_behaves_like 'displays_banner_warning_for_whitelisted_welsh_nontools' do
        let(:url) { 'www.example.com/cy/opsiynau-incwm-ymddeoliad/retirement-options' }
      end
    end
  end
end
