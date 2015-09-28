RSpec.describe ActionPlansController, type: :controller do
  let(:categories) { [] }
  let(:action_plan) { Core::ActionPlan.new('test', categories: categories) }
  let(:action_plan_reader) { instance_double(Core::ActionPlanReader, call: action_plan) }

  describe 'GET show' do
    context 'when action plan exists' do
      before do
        allow(Core::ActionPlanReader).to receive(:new) { -> { action_plan } }
        allow(controller).to receive(:category_tree)
      end

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
    end

    context 'when an action plan does not exist' do
      before do
        allow_any_instance_of(Core::ActionPlanReader).to receive(:call).and_yield(action_plan)
      end

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end

    context 'when action plan is redirected' do
      let(:redirect) do
        OpenStruct.new(redirect?: true,
                       location: 'https://example.com',
                       status: 301)
      end

      before do
        allow_any_instance_of(Core::ActionPlanReader).to receive(:call).and_yield(redirect)
      end

      it 'redirects' do
        get :show, id: 'redirect', locale: I18n.locale
        expect(response).to redirect_to('https://example.com')
      end
    end
  end
end
