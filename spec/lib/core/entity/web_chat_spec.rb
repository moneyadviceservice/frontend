RSpec.describe Core::WebChat do
  let(:params) do
    {
      heading: 'Web Chat',
      additional_one: 'Mon-Fri 8am-6pm',
      additional_two: 'Sat 10am-4pm',
      additional_three: 'closed Sun',
      small_print: 'small print'
    }
  end

  subject { described_class.new(params) }

  describe 'attributes' do
    it { expect(subject.heading).to eq('Web Chat') }
    it { expect(subject.additional_one).to eq('Mon-Fri 8am-6pm') }
    it { expect(subject.additional_two).to eq('Sat 10am-4pm') }
    it { expect(subject.additional_three).to eq('closed Sun') }
    it { expect(subject.small_print).to eq('small print') }
  end
end
