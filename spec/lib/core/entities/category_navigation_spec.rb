require 'spec_helper'
require 'core/entities/category_navigation'

module Core
  describe CategoryNavigation do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title:          double,
                         description:    double,
                         sub_categories: double } }

    it { should respond_to :title }
    it { should respond_to :title= }

    it { should respond_to :description }
    it { should respond_to :description= }

    it { should respond_to :sub_categories }
    it { should respond_to :sub_categories= }
  end
end
