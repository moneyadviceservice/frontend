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
      let(:old_first_name) { 'Phil' }
      let(:new_first_name) { 'Philip' }

      it 'updates the customer' do
        user = User.new(first_name: old_first_name)
        customer_id = subject.create(user)

        customer = Customer.new(customer_id, first_name: new_first_name)
        subject.update(customer)

        expect(subject.find(id: customer_id).first_name).to eql(new_first_name)
      end

      context 'when the customer does not exist' do
        it 'throws an exception' do
          customer = Customer.new('phil', first_name: old_first_name)

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
