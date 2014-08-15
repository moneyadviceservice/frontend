module Core
  RSpec.describe Repository::Customers::Fake do
    before :each do
      subject.clear
    end

    describe '#find' do
      context 'when the customer is non-existent' do
        it { expect(subject.find('unknown')).to be_nil }
      end

      context 'when the customer exists' do
        before :each do
          customer = Customer.new('known', first_name: 'exists')
          subject.create(customer)
        end

        it { expect(subject.find('known').id).to eql('known') }
      end
    end

    describe '#create' do
      it 'creates the customer' do
        customer = Customer.new(nil, first_name: 'Phil')
        subject.create(customer)

        expect(subject.customers).to_not be_empty
      end

      it 'returns the customer id' do
        customer = Customer.new(nil, first_name: 'Phil')
        expect(subject.create(customer)).to match(/\Acustomer_(\d)*\z/)
      end

      context 'when the customer already exists' do
        it 'throws an exception' do
          customer = Customer.new('phil', first_name: 'Phil')
          subject.create(customer)

          expect{ subject.create(customer) }.to raise_error
        end
      end
    end

    describe '#update' do
      it 'updates the customer' do
        customer = Customer.new('phil', first_name: 'Phil')
        subject.create(customer)

        customer = Customer.new('phil', first_name: 'Philip')
        subject.update(customer)

        expect(subject.find('phil').first_name).to eql('Philip')
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
          customer = Customer.new('customer_id', first_name: 'Phil')
          subject.create(customer)

          expect(subject.valid_for_authentication?('customer_id')).to be_truthy
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
