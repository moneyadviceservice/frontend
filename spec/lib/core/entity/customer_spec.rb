module Core
  RSpec.describe Customer do
    subject { described_class.new(customer_id, attributes) }

    let(:customer_id) { 'customer_123' }
    let(:attributes) do
      {
        first_name: 'Phil',
        last_name: 'Lee',
        email: 'phil@example.com',
        post_code: 'NE1 6EE',
        age_range: '0-15',
        gender: 'male',
        state: 0,
        topics: [1, 2, 3],
        newsletter_subscription: true,
        date_of_birth: Time.new(1988, 1, 1),
        status_code: '123'
      }
    end

    it { expect(subject.id).to eql('customer_123') }
    it { expect(subject.first_name).to eql('Phil') }
    it { expect(subject.last_name).to eql('Lee') }
    it { expect(subject.email).to eql('phil@example.com') }
    it { expect(subject.post_code).to eql('NE1 6EE') }
    it { expect(subject.age_range).to eql('0-15') }
    it { expect(subject.gender).to eql('male') }
    it { expect(subject.state).to eql(0) }
    it { expect(subject.topics).to eql([1, 2, 3]) }
    it { expect(subject.newsletter_subscription).to eql(true) }
    it { expect(subject.date_of_birth).to eql(Time.new(1988, 1, 1)) }
    it { expect(subject.status_code).to eql('123') }

    describe '#active?' do
      context 'when state is 0' do
        it 'returns true' do
          subject.state = 0
          expect(subject.active?).to be_truthy
        end
      end
    end

    describe '#to_crm_hash' do
      it 'returns hash with correct attributes' do
        expected = {
          FirstName: attributes[:first_name],
          LastName: attributes[:last_name],
          mas_ContactEmail: attributes[:email],
          Address1_PostalCode: attributes[:post_code],
          GenderCode: { Value: Customer::GENDER_MAP[attributes[:gender]] },
          mas_AgeRange: { Value: Customer::AGE_RANGES_MAP[attributes[:age_range]] },
          BirthDate: attributes[:date_of_birth].to_time.utc.iso8601,
          DoNotBulkEMail: !attributes[:newsletter_subscription]
        }

        expect(subject.to_crm_hash).to eql(expected)
      end
    end
  end
end
