require 'spec_helper'
require 'core/entities/category'

describe CategoryDecorator do
  include Draper::ViewHelpers

  subject(:decorator) { described_class.decorate(category) }

  let(:category) do
    double(Core::Category, id: double, title: double, description: double)
  end

  it { should respond_to(:path) }
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:contents) }

  describe '#path' do
    before { helpers.stub(category_path: '/categories/test') }

    it 'returns the path to the category' do
      expect(subject.path).to eq('/categories/test')
    end
  end
end
