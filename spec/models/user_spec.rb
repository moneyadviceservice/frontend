require 'spec_helper'

RSpec.describe User, :type => :model do

  subject(:user) { described_class.new(attributes) }

  let(:attributes) { { email:                 'david@example.com',
                       password:              'password',
                       password_confirmation: 'password' } }

  describe '#fake_send_confirmation_email' do
    it "sends a fake confirmation email when user is saved" do
      user.save!
      expect(user.confirmation_sent_at).to_not be_nil
    end
  end
end
