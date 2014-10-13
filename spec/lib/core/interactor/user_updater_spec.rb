require 'spec_helper'

module Core
  module Interactors
    RSpec.describe UserUpdater do
      let!(:user) do
        FactoryGirl.create :user
      end
      subject { described_class.new user }

      describe '#call' do
        it 'updates the user' do
          customer = Core::Registry::Repository[:customer].customers.first
          customer[:first_name] = 'Philip'

          subject.call

          expect(user.reload.first_name).to eql('Philip')
        end
      end
    end
  end
end
