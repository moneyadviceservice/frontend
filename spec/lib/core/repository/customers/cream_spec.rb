require 'spec_helper'

module Core
  RSpec.describe Repository::Customers::Cream do
    describe '#create' do
      let(:user){ User.new }
      let(:response) do
        {
          'd' => { 'ContactId' => '123' }
        }
      end

      it 'uses cream client to create' do
        client = double("client", create_customer: response)
        expect(::Cream::Client).to receive(:instance).and_return(client)

        expect(client).to receive(:create_customer).with(user).and_return(response)
        expect(subject.create(user)).to eql('123')
      end
    end
  end
end
