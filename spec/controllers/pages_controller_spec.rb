RSpec.describe PagesController, :type => :controller do
  describe 'GET show' do
    context 'when a page does exist' do
      it 'is successful' do
        get :show, id: 'car', locale: I18n.locale

        expect(response).to be_ok
      end

      context 'when requesting a dodgy looking page' do
        it 'is sanitized' do
          get :show, id: '../car', locale: I18n.locale

          expect(response).to be_ok
        end
      end
    end

    context 'when the page does not exist' do
      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'idontexist', locale: I18n.locale }.
          to raise_error(ActionController::RoutingError)
      end
    end
  end
end
