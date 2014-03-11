require 'spec_helper'
require 'core/entities/article'

module Core
  describe Article do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title:       double,
        description: double,
        body:        double,
        alternate:   { title: double, url: double } }
    end

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :body }
    it { should respond_to :body= }

    it { should respond_to :alternate }
    it { should respond_to :alternate= }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }

    its(:alternate) { should be_a(Article::Alternate) }
  end
end
