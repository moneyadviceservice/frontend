RSpec.describe Core::Repository::Customers::Fake do
  describe 'find' do
    context 'when the customer is non-existent' do
      it { expect(subject.find('unknown')).to be_nil }
    end

    context 'when the customer exists' do
      subject{ described_class.new.find('known') }

      it { expect(subject.id).to eql('known') }
    end
  end
end
