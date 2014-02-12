require 'spec_helper'
require 'core/entities/entity'

module Core
  describe Entity do
    subject { described_class.new(double, attributes) }

    let(:attributes) { Hash.new }

    it { should respond_to :id }
    it { should_not respond_to :id= }

    it { should validate_presence_of(:id) }
  end
end
