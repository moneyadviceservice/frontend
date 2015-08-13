module Validators
  class TestEmailValidatorModel
    include ActiveModel::Model

    attr_accessor :email

    validates_with Validators::Email, attributes: [:email]
  end

  class TestEmailWithDnsValidatorModel
    include ActiveModel::Model

    attr_accessor :email

    validates_with Validators::Email, attributes: [:email],
                                      dns_validation?: true
  end

  RSpec.describe Email do
    subject { TestEmailValidatorModel.new }

    context 'when email is blank' do
      it { is_expected.not_to be_valid }
    end

    context 'when format is invalid' do
      before :each do
        subject.email = 'notanemail.com'
      end

      it { is_expected.not_to be_valid }
    end

    context 'when format is valid' do
      subject { TestEmailWithDnsValidatorModel.new }

      before :each do
        subject.email = 'me@example.com'
      end

      context 'when dns lookup is valid' do
        before :each do
          allow(PostcodeAnywhere::EmailValidation).to receive(:valid?) { true }
        end

        it { is_expected.to be_valid }
      end

      context 'when dns lookup is invalid' do
        before :each do
          allow(PostcodeAnywhere::EmailValidation).to receive(:valid?) { false }
        end

        it { is_expected.to_not be_valid }
      end
    end
  end
end
