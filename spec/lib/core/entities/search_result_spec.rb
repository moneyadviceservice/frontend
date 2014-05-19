require 'spec_helper'
require 'core/entities/search_result'

module Core
  describe SearchResult do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title: double, description: double } }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end
end
