RSpec.describe SessionsController, type: :controller do

  describe '#new' do
    context 'non xhr requests' do
      it 'returns a 200' do
        get :new, locale: :en

        expect(response).to be_success
      end
    end

    context 'xhr requests' do
      it 'returns a 501' do
        xhr :get, :new, locale: :en

        expect(response.status).to eql(501)
      end
    end
  end
end
