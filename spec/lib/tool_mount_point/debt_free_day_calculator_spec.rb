require 'tool_mount_point/base'
require 'tool_mount_point/debt_free_day_calculator'

RSpec.describe ToolMountPoint::DebtFreeDayCalculator do

  describe '#matches?' do

    context 'for the Loan Calculator' do
      it 'matches a request for the English version' do
        request = double('request', params: {
          locale: 'en',
          tool_id: 'loan-calculator',
        })

        expect(subject.matches?(request)).to be_truthy
      end

      it 'matches a request for the Welsh version' do
        request = double('request', params: {
          locale: 'cy',
          tool_id: 'cyfrifiannell-benthyciadau',
        })

        expect(subject.matches?(request)).to be_truthy
      end
    end

    context 'for the Credit Card Calculator' do
      it 'matches a request for the English version' do
        request = double('request', params: {
          locale: 'en',
          tool_id: 'credit-card-calculator',
        })

        expect(subject.matches?(request)).to be_truthy
      end

      it 'matches a request for the Welsh version' do
        request = double('request', params: {
          locale: 'cy',
          tool_id: 'cyfrifiannell-cerdyn-credyd',
        })

        expect(subject.matches?(request)).to be_truthy
      end
    end

  end

  describe '#alternate_tool_id' do
    context 'for the Loan Calculator' do
      it 'returns the Welsh translation when given the tool_id in English' do
        expect(subject.alternate_tool_id('loan-calculator'))
          .to eq('cyfrifiannell-benthyciadau')
      end

      it 'returns the English translation when given the tool_id in Welsh' do
        expect(subject.alternate_tool_id('cyfrifiannell-benthyciadau'))
          .to eq('loan-calculator')
      end
    end

    context 'for the Credit Card Calculator' do
      it 'returns the Welsh translation when given the tool_id in English' do
        expect(subject.alternate_tool_id('credit-card-calculator'))
          .to eq('cyfrifiannell-cerdyn-credyd')
      end

      it 'returns the English translation when given the tool_id in Welsh' do
        expect(subject.alternate_tool_id('cyfrifiannell-cerdyn-credyd'))
          .to eq('credit-card-calculator')
      end
    end
  end

  describe "#en_id" do
    it 'is not supported' do
      expect { subject.en_id }.to raise_error(
        'Unsupported: there is no logical implementation of `en_id` for this class')
    end
  end

  describe "#cy_id" do
    it 'is not supported' do
      expect { subject.cy_id }.to raise_error(
        'Unsupported: there is no logical implementation of `cy_id` for this class')
    end
  end

end
