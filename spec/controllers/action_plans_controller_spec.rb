require 'spec_helper'
require 'core/interactors/action_plan_reader'
require 'core/entities/action_plan'

describe ActionPlansController do
  let(:action_plan) { double(Core::ActionPlan, id: 'test') }
  let(:action_plan_reader) { double(Core::ActionPlanReader, call: action_plan) }

  before { allow_any_instance_of(Core::ActionPlanReader).to receive(:call) { action_plan } }

  describe 'GET show' do
    it 'is successful' do
      get :show, locale: I18n.locale, id: 'foo'

      expect(response).to be_ok
    end

    it 'instantiates an action plan reader' do
      expect(Core::ActionPlanReader).to receive(:new).with(action_plan.id) { action_plan_reader }

      get :show, locale: I18n.locale, id: action_plan.id
    end

    it 'assigns @action_plan to the result of action_plan reader' do
      get :show, locale: I18n.locale, id: action_plan.id

      expect(assigns(:action_plan)).to eq(action_plan)
    end
  end
end
