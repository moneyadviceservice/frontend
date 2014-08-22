require 'spec_helper'

RSpec.describe RegistrationsController, type: :controller do
  describe '#build_resource' do
    it 'sets user to have accepted terms and conditions' do
      allow(subject).to receive(:resource_class) { User }
      allow(subject).to receive(:resource_name) { 'user' }
      subject.send :build_resource, { first_name: 'Phil' }
      expect(subject.resource.accept_terms_conditions).to be_truthy
    end
  end
end
