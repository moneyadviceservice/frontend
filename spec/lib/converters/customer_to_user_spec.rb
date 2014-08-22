require 'spec_helper'

module Converters
  RSpec.describe CustomerToUser do
    context 'when user exists' do
      let(:customer){ Core::Customer.new(user.customer_id, first_name: 'Philip') }
      let!(:user) do
        Rails.configuration.active_record.record_timestamps = true
        user = User.new(first_name: 'Phil',
                        email: 'phil@example.com',
                        password: 'password',
                        post_code: 'NE1 6EE')
                        user.save
                        user
      end
      subject{ described_class.new(customer) }

      it 'finds the user' do
        expect(subject.call).to eql(user)
      end

      it 'updates new attributes' do
        expect(User).to receive(:find_by).with(customer_id: customer.id){ user }
        subject.call
        expect(user.first_name).to eql('Philip')
        expect(user.email).to eql('phil@example.com')
      end
    end

    context 'when user does not exist' do
      let(:customer){ Core::Customer.new('customer_phil', first_name: 'Phil') }
      subject{ described_class.new(customer) }

      it 'builds a user object' do
        user = subject.call

        expect(user).to be_a(User)
        expect(user.first_name).to eql('Phil')
      end

      it 'sets user.customer_id' do
        user = subject.call

        expect(user.customer_id).to eql('customer_phil')
      end
    end

    context 'when customer is not persisted' do
      let(:customer){ Core::Customer.new(nil, first_name: 'Phil') }
      subject{ described_class.new(customer) }

      it 'raise en exception' do
        expect{ subject.call }.to raise_error
      end
    end
  end
end
