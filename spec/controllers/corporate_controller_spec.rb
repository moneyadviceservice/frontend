RSpec.describe CorporateController, type: :controller do
  describe 'GET show' do
    let(:corporate) { instance_double(Core::Article, id: 'test', categories: []) }
    let(:corporate_reader) { instance_double(Core::CorporateReader, call: corporate) }

    before do
      allow(Core::CategoryTreeReader).to receive(:new) { -> { double } }
    end

    context 'when corporate page exists' do
      before do
        expect(Core::CorporateReader).to receive(:new).with(corporate.id) { corporate_reader }
        get :show, locale: I18n.locale, id: corporate.id
      end

      it 'responds successfuly' do
        expect(response).to be_ok
      end

      it 'assigns corporate page' do
        expect(assigns[:article]).to be(corporate)
      end
    end

    context 'when corporate page does not exist' do
      it 'raises an ActionController RoutingError' do
        allow(Core::CorporateReader).to receive(:new) { ->(&block) { block.call } }

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
