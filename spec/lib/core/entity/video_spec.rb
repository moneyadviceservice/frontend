RSpec.describe Core::Video do
  let(:params) do
    { type: 'no-idea-about-type',
      title: 'awesome-title',
      description: 'awesome-description',
      body: 'awesome-body',
      categories: [:foo, :bar],
      alternates: [:cy]}
  end

  subject do
    described_class.new('some-video', params)
  end

  describe 'attributes' do
    it 'are set' do
      %i{ type title description body categories alternates }.each do |attr|
        expect(subject.public_send(attr)).to eql(params[attr])
      end
    end
  end

  describe '#redirect?' do
    it 'returns false' do
      expect(subject.redirect?).to be_falsey
    end
  end
end
