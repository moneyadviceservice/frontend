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
        before :each do
          user = User.new(first_name: 'exists', email: 'phil@example.com')
          @customer_id = subject.create(user)
        end

        it { expect(subject.find(id: @customer_id).first_name).to eql('exists') }
        it { expect(subject.find(email: 'phil@example.com').first_name).to eql('exists') }
      end
    end

    describe '#create' do
      it 'creates the customer' do
        user = User.new(first_name: 'Phil')
        subject.create(user)

        expect(subject.customers).to_not be_empty
      end

      it 'returns the customer id' do
        user = User.new(first_name: 'Phil')
        expect(subject.create(user)).to match(/\Acustomer_(\d)*\z/)
      end

      context 'when the customer already exists' do
        it 'throws an exception' do
          user = User.new(first_name: 'Phil')
          customer_id = subject.create(user)
          user.customer_id = customer_id

          expect{ subject.create(user) }.to raise_error
        end
      end
    end

    describe '#update' do
      it 'updates the customer' do
        user = User.new(first_name: 'Phil')
        customer = Customer.new(nil, first_name: 'Phil')
        customer_id = subject.create(user)

        customer = Customer.new(customer_id, first_name: 'Philip')
        subject.update(customer)

        expect(subject.find(id: customer_id).first_name).to eql('Philip')
      end

      context 'when the customer does not exist' do
        it 'throws an exception' do
          customer = Customer.new('phil', first_name: 'Phil')

          expect{ subject.update(customer) }.to raise_error('does not exist')
        end
      end
    end

    describe '#valid_for_authentication?' do
      context 'when customer exists' do
        it 'returns true' do
          user = User.new(first_name: 'Phil')
          customer = Customer.new(nil, first_name: 'Phil')
          customer_id = subject.create(user)

          expect(subject.valid_for_authentication?(customer_id)).to be_truthy
        end
      end

      context 'when customer does not exist' do
        it 'returns false' do
          expect(subject.valid_for_authentication?('customer_id')).to be_falsey
        end
      end
    end
  end
end
