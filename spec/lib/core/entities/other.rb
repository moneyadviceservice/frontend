require 'spec_helper'
require 'core/entities/other'

module Core
  describe Other do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title: double }
    end

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }
  end
end
