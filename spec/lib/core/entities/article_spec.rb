require 'spec_helper'
require 'core/entities/article'

module Core
  describe Article do
    subject { described_class.new(double) }

    it { should respond_to :id }
    it { should_not respond_to :id= }

    it { should respond_to :url }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :body }
    it { should respond_to :body= }

    it { should validate_presence_of(:id) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end
end
