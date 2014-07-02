RSpec.describe ActionPlansController, :type => :controller do
  let(:action_plan) { instance_double(Core::ActionPlan, id: 'test', categories: []) }
  let(:action_plan_reader) { instance_double(Core::ActionPlanReader, call: action_plan) }

  before do
    allow(Core::ActionPlanReader).to receive(:new) { -> { action_plan } }
    allow(controller).to receive(:category_tree)
  end

  describe 'GET show' do
    it 'is successful' do
      get :show, locale: I18n.locale, id: action_plan.id

      expect(response).to be_ok
    end

    it 'instantiates an ActionPlanReader' do
      expect(Core::ActionPlanReader).to receive(:new).with(action_plan.id) { action_plan_reader }

      get :show, locale: I18n.locale, id: action_plan.id
    end

    it 'assigns @action_plan to the result of ActionPlanReader' do
      get :show, locale: I18n.locale, id: action_plan.id

      expect(assigns(:action_plan)).to eq(action_plan)
    end

    context 'when an action plan does not exist' do
      it 'raises an ActionController RoutingError' do
        allow(Core::ActionPlanReader).to receive(:new) { ->(&block) { block.call } }

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
