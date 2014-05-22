require_relative 'shared_examples/optional_failure_block'

require 'core/entities/action_plan'
require 'core/interactors/action_plan_reader'

module Core
  RSpec.describe ActionPlanReader do
    subject { described_class.new(id) }

    let(:id) { 'the-action-plan' }

    describe '.call' do
      before do
        allow(Registries::Repository).to receive(:[]).with(:action_plan) do
          double(find: data)
        end
      end

      context 'when the repository returns no data' do
        let(:data) { nil }

        it_has_behavior 'optional failure block'
      end

      context 'when the repository returns some data' do
        let(:title) { 'The Action Plan' }
        let(:data) { { title: title } }

        context 'when a block is given' do
          let(:probe) { lambda {} }

          it 'calls the block' do
            expect(probe).to receive(:call)

            subject.call(&probe)
          end
        end

        context 'when no block is given' do
          it 'returns nil' do
            expect(subject.call).to be_nil
          end
        end
      end

      context 'when the repository returns data' do
        let(:title) { 'The Action Plan' }
        let(:description) { 'The Action Plan has a description' }
        let(:body) { '<h1>The Action Plan</h1><p>Lorem ipsum dolor sit amet</p>' }

        let(:data) do
          { title: title, description: description, body: body }
        end

        it "maps the action_plan's `id' to the repositories' `id' value" do
          expect(ActionPlan).
            to receive(:new).with(id, kind_of(Hash)).and_call_original

          subject.call
        end

        %W(title description body).each do |attribute|
          it "maps the article's `#{attribute}' to the repositories' `#{attribute}' value" do
            expect(ActionPlan).to(receive(:new)) { |_, attributes|
              expect(attributes[attribute.to_sym]).to eq(send(attribute))
            }.and_call_original

            subject.call
          end
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
      end

    end
  end
end
