RSpec.describe Core::Repository::Footer::CMS do
  describe '#find' do
    context 'when the footer exists' do
      it 'returns the footer' do
        result = subject.find('footer')
        expect(result['label']).to eql('Footer')
      end
    end

    context 'when footer does not exist' do
      it 'raises an exception' do
        expect { subject.find('idonotexist') }.to raise_error(Core::Repository::Base::RequestError)
      end
    end
  end
end
