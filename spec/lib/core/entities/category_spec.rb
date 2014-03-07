require 'spec_helper'
require 'core/entities/category'

module Core
  describe Category do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title:       double,
                         description: double,
                         contents:    double } }

    it { should respond_to :type }
    it { should respond_to :type= }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :contents }
    it { should respond_to :contents= }

    it { should validate_presence_of(:title) }
  end
end
