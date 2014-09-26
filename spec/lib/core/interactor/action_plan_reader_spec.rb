require_relative 'shared_examples/optional_failure_block'

module Core
  RSpec.describe ActionPlanReader do
    subject { described_class.new(id) }

    let(:id) { 'the-action-plan' }

    describe '.call' do
      before do
        allow(Registry::Repository).to receive(:[]).with(:action_plan) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns data' do
        let(:title) { 'The Action Plan' }
        let(:description) { 'The Action Plan has a description' }
        let(:body) { '<h1>The Action Plan</h1><p>Lorem ipsum dolor sit amet</p>' }
        let(:categories) { [] }

        let(:data) do
          { title: title, description: description, body: body, categories: categories }
        end

        it 'instantiates the action plan with the id and the attributes from the repository' do
          expect(ActionPlan).
            to receive(:new).with(id, data).and_call_original

          subject.call
        end

        context 'when the Action Plan entity is valid' do
          before do
            expect_any_instance_of(ActionPlan).to receive(:valid?) { true }
          end

          it 'returns an Action Plan' do
            expect(subject.call).to be_a(ActionPlan)
          end
        end

        context 'when the Action Plan is invalid' do
          before do
            expect_any_instance_of(ActionPlan).to receive(:valid?) { false }
          end

          it_has_behavior 'optional failure block'
        end

        context 'when there is a category' do
          let(:category_id) { 'category-id' }
          let(:categories)  { [category_id] }
          let(:category)    { double }

          before do
            allow(CategoryReader).to receive(:new).with(category_id) { -> { category } }
          end

          it 'populates the category entity' do
            expect(subject.call.categories).to eql [category]
          end
        end
      end

    end
  end
end
