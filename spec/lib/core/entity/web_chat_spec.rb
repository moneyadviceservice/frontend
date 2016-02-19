RSpec.describe Core::WebChat do
  let(:params) { { times: 'Mon-Fri 8am-6pm' } }

  subject { described_class.new(params) }

  describe 'attributes' do
    it 'sets #times' do
      expect(subject.times).to eq('Mon-Fri 8am-6pm')
    end
  end
end
