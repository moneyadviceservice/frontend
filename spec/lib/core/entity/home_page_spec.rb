module Core
  RSpec.describe HomePage do
    subject { described_class.new(double, attributes) }

    let(:attributes) { Hash.new }

    it 'has correct attributes' do
      [:promo_banner_url, :promo_banner_url].each do |attr|
        expect(subject).to respond_to(attr)
      end
    end
  end
end
