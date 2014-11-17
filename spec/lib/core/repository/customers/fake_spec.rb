module Core
  RSpec.describe Repository::Customers::Fake do
    before :each do
      subject.clear
    end

    describe '#find' do
      context 'when the customer is non-existent' do
        it { expect(subject.find(id: 'unknown')).to be_nil }
      end

      context 'when the customer exists' do
        let(:email) { 'phil@example.com' }

        before :each do
          user = User.new(first_name: 'exists', email: email)
          @customer_id = subject.create(user)
        end

        it { expect(subject.find(id: @customer_id).first_name).to eql('exists') }
        it { expect(subject.find(email: email).first_name).to eql('exists') }
      end
    end

    describe '#create' do
      let(:first_name) { 'Phil' }

      it 'creates the customer' do
        user = User.new(first_name: first_name)
        subject.create(user)

        expect(subject.customers).to_not be_empty
      end

      it 'returns the customer id' do
        user = User.new(first_name: first_name)
        expect(subject.create(user)).to match(/\Acustomer_(\d)*\z/)
      end

      context 'when the customer already exists' do
        it 'throws an exception' do
          user = User.new(first_name: first_name)
          customer_id = subject.create(user)
          user.customer_id = customer_id

          expect { subject.create(user) }.to raise_error
        end
      end
    end

    describe '#update' do
      let(:old_attributes) do
        {
          first_name: 'Phil',
          email: 'phil@example.com',
          post_code: 'NE1 6EE',
          newsletter_subscription: true
        }
      end

      let(:new_attributes) do
        {
          first_name: 'Jon',
          email: 'jon@example.com',
          post_code: 'NE2 8EE',
          newsletter_subscription: false
        }
      end
      let(:user) { User.new(old_attributes) }
      let(:customer_id) { subject.create(user) }
      let(:customer) { Customer.new(customer_id, new_attributes) }

      context 'personal details' do

        before(:each) do
          subject.update(customer)
        end

        it 'updates the customers first name' do
          expect(subject.find(id: customer_id).first_name).to eql(new_attributes[:first_name])
        end

        it 'updates the customers email address' do
          expect(subject.find(id: customer_id).email).to eql(new_attributes[:email])
        end

        it 'updates the customers post code' do
          expect(subject.find(id: customer_id).post_code).to eql(new_attributes[:post_code])
        end

        it 'updates the customers newsletter subscription settings' do
          expect(subject.find(id: customer_id).newsletter_subscription).to eql(new_attributes[:newsletter_subscription])
        end
      end

      context 'when the customer does not exist' do
        it 'throws an exception' do
          customer = Customer.new('phil', first_name: old_attributes[:first_name])

          expect { subject.update(customer) }.to raise_error('does not exist')
        end
      end
    end

    describe '#valid_for_authentication?' do
      let(:user) { User.new(first_name: 'Phil') }
      let(:customer_id) { subject.create(user) }

      it 'returns true' do
        expect(subject.valid_for_authentication?(customer_id)).to be_truthy
      end
    end
  end
end
