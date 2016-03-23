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
    context 'english pages for tools' do
      ['redundancy-pay-calculator',
       'workplace-pension-contribution-calculator',
       'pension-calculator'].each do |tool_name|
        describe tool_name do
          it "displays warning banner for #{tool_name}" do
            request = double('request', url: "www.example.com/en/tools/#{tool_name}/",
                                     base_url: 'www.example.com')
            allow(BudgetWarning).to receive(:request).and_return(request)

            expect(described_class.whitelisted?).to be(true)
          end
        end
      end
    end

    context 'english pages non-tools' do
       it 'displays warning banner for retirement-income-options' do
         request = double('request', url: "www.example.com/en/retirement-income-options/",
                                  base_url: 'www.example.com')
         allow(BudgetWarning).to receive(:request).and_return(request)

         expect(described_class.whitelisted?).to be(true)
       end

       it "displays warning banner for income-drawdown" do
          request = double('request', url: "www.example.com/en/retirement-income-options/income-drawdown",
                                   base_url: 'www.example.com')
          allow(BudgetWarning).to receive(:request).and_return(request)

          expect(described_class.whitelisted?).to be(true)
       end
    end

    context 'welsh pages for tools' do
       ['cyfrifiannell-tal-diswyddo',
        'cyfrifiannell-cyfraniadau-pensiwn-gweithle',
        'cyfrifiannell-pensiwn'].each do |tool_name|
         describe tool_name do
           it "displays warning banner for #{tool_name}" do
             request = double('request', url: "www.example.com/cy/tools/#{tool_name}/",
                                      base_url: 'www.example.com')
             allow(BudgetWarning).to receive(:request).and_return(request)

             expect(described_class.whitelisted?).to be(true)
           end
         end
       end
    end

    context 'welsh pages for non-tools' do
        # Retirement Income Options
        ['opsiynau-incwm-ymddeoliad'].each do |tool_name|
          describe tool_name do
            it "displays warning banner for #{tool_name}" do
              request = double('request', url: "www.example.com/cy/#{tool_name}/",
                                       base_url: 'www.example.com')
              allow(BudgetWarning).to receive(:request).and_return(request)

              expect(described_class.whitelisted?).to be(true)
            end
          end
        end

        # Income Drawdown
        ['income-drawdown'].each do |tool_name|
         describe tool_name do
           it "displays warning banner for #{tool_name}" do
             request = double('request', url: "www.example.com/cy/opsiynau-incwm-ymddeoliad/#{tool_name}",
                                      base_url: 'www.example.com')
             allow(BudgetWarning).to receive(:request).and_return(request)

             expect(described_class.whitelisted?).to be(true)
           end
         end
        end
     end
  end
end
