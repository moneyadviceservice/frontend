require 'spec_helper'
require 'core/entities/entity'

module Core
  describe Entity do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title:       double,
                         description: double,
                         body:        double } }

    it { should respond_to :id }
    it { should_not respond_to :id= }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :body }
    it { should respond_to :body= }

    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
