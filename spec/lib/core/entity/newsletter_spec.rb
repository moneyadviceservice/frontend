RSpec.describe Core::Newsletter do
  let(:params) do
    {
      heading: 'Newsletter',
      introduction: 'FREE money advice newsletter.',
    }
  end

  subject { described_class.new(params) }

  describe 'attributes' do
    it { expect(subject.heading).to eq('Newsletter') }
    it { expect(subject.introduction).to eq('FREE money advice newsletter.') }
  end
end
