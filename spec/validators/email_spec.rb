require 'spec_helper'

module Validators
  class TestEmailValidatorModel
    include ActiveModel::Model

    attr_accessor :email

    validates_with Validators::Email, attributes: [:email]
  end

  RSpec.describe Email do
    subject { TestEmailValidatorModel.new }

    context 'when email is blank' do
      it { should_not be_valid }
    end

    context 'when email is present' do
      context 'when format is valid' do
        before :each do
          subject.email = 'me@example.com'
        end

        it { should be_valid }
      end

      context 'when format is invalid' do
        before :each do
          subject.email = 'notanemail.com'
        end

        it { should_not be_valid }
      end
    end
  end
end

