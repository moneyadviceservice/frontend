module Core
  RSpec.describe HomePage, type: :model do
    subject { described_class.new(double, attributes) }

    let(:attributes) { {} }

    it 'has correct attributes' do
      expect(subject).to respond_to(:promo_banner_url)
    end
  end
end
