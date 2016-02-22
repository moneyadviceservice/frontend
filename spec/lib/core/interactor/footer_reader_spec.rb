RSpec.describe Core::FooterReader do

  subject { Core::FooterReader.new('footer') }

  describe '#call' do
    it 'creates a Footer object' do
      expect(subject.call).to be_a(Core::Footer)
    end
  end
end
