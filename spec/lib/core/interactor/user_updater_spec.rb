module Core
  module Interactors
    RSpec.describe UserUpdater do
      let(:user) do
        FactoryGirl.create :user
      end
      subject { described_class.new user }

      before :each do
        Customer::Creator.new(user).call
      end

      describe '#call' do
        context 'when customer id is present' do
          it 'updates the user' do
            customer = Core::Registry::Repository[:customer].customers.first
            customer[:first_name] = 'Philip'

            subject.call

            expect(user.reload.first_name).to eql('Philip')
          end
        end

        context 'when customer id is blank' do
          let(:user) { double(customer_id: nil).as_null_object }

          it 'returns nil' do
            expect(subject.call).to be_nil
          end
        end
      end
    end
  end
end
