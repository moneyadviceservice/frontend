require_relative 'shared_examples/optional_failure_block'

require 'core/entities/category'
require 'core/interactors/category_navigation_reader'

module Core
  RSpec.describe CategoryNavigationReader, '#call' do
    subject { described_class.new }

    before do
      allow(Registries::Repository).to receive(:[]).with(:category) do
        double(all: data)
      end
    end

    context 'when the repository returns no data' do
      let(:data) { nil }

      it_has_behavior 'optional failure block'
    end

    context 'when the repository returns data' do
      let(:data) do
        [{
           'id'          => 'life-events',
           'type'        => 'category',
           'title'       => 'Life events',
           'description' => 'When big things happen - having a baby, losing your job, getting divorced or retiring\n - it helps to be in control of your money\n',
           'contents'    => [{
                               'id'          => 'setting-up-home',
                               'type'        => 'category',
                               'title'       => 'Setting up home',
                               'description' => 'Deciding whether to rent or buy, working out what you can afford and managing\n money when sharing with others\n',
                               'contents'    => []
                             }]
         }]
      end
      let(:result) { subject.call }

      it 'contains categories' do
        expect(result.first).to be_a(Category)
      end

      it 'contains subcategories' do
        expect(result.first.contents.first).to be_a(Category)
      end
    end
  end
end
