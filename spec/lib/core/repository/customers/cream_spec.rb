require 'spec_helper'

module Core
  RSpec.describe Repository::Customers::Cream do
    describe '#find' do
      context 'when customer exists' do
        let(:client){ double("client", find_customer: response) }
        let(:user){ User.new }
        let(:response) { JSON.parse(File.read('spec/fixtures/customers/cream_response.json')) }

        it 'returns the customer' do
          expect(::Cream::Client).to receive(:instance).and_return(client)

          expect(client).to receive(:find_customer).with(customer_id: 123).and_return(response)

          expect(subject.find(id: 123)).to be_a(Customer)
        end
      end

      context 'when customer does not exist' do
        let(:client) { double('client', find_customer: response) }
        let(:user) { User.new }
        let(:response) do
          { 'd' => { 'results' => [] } }
        end

        it 'returns nil' do
          expect(::Cream::Client).to receive(:instance).and_return(client)

          expect(client).to receive(:find_customer).with(customer_id: 123).and_return(response)

          expect(subject.find(id: 123)).to be_nil
        end
      end
    end

    describe '#create' do
      let(:user) { User.new }
      let(:mas_customer_id) { '123' }
      let(:response) do
        {
          'd' => { 'mas_CustomerId' => mas_customer_id }
        }
      end

      it 'uses cream client to create' do
        client = double('client', create_customer: response)
        expect(::Cream::Client).to receive(:instance).and_return(client)

        expect(client).to receive(:create_customer).with(user).and_return(response)
        expect(subject.create(user)).to eql(mas_customer_id)
      end
    end

    describe '#update' do
      context 'when customer exists' do
        let(:client) { double('client', find_customer: response) }
        let(:user) { FactoryGirl.create(:user) }
        let(:response) { true }

        it 'updates the customer' do
          client = double('client', create_customer: response)
          expect(::Cream::Client).to receive(:instance).and_return(client)

          expect(client).to receive(:update_customer).with(user.customer_id, kind_of(Hash)).and_return(response)
          expect(subject.update(user.to_customer)).to eql(response)
        end
      end
    end

    describe '#valid_for_authentication?' do
      let(:id) { 1 }

      context 'when they exist in crm' do
        it 'returns true' do
          allow(subject).to receive(:find).with(id: id) { Object.new }
          expect(subject.valid_for_authentication?(id)).to be_truthy
        end
      end

      context 'when they no not exist in crm' do
        it 'returns false' do
          allow(subject).to receive(:find) { nil }
          expect(subject.valid_for_authentication?(id)).to be_falsey
        end
      end
    end
  end
end
