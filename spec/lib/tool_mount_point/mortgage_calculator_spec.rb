require 'tool_mount_point/base'
require 'tool_mount_point/mortgage_calculator'

RSpec.describe ToolMountPoint::MortgageCalculator do

  describe '#alternate_tool_id' do
    context 'switching the tool id from english to its welsh aternative' do
      it { expect(subject.alternate_tool_id('mortgage-calculator')).to eq('cyfrifiannell-morgais') }
      it { expect(subject.alternate_tool_id('house-buying')).to eq('prynu-ty') }
    end

    context 'from welsh to its english' do
      it { expect(subject.alternate_tool_id('cyfrifiannell-morgais')).to eq('mortgage-calculator') }
      it { expect(subject.alternate_tool_id('prynu-ty')).to eq('house-buying') }
    end
  end

end
