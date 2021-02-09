RSpec.describe PaceController, type: :controller do
  describe '#online' do
    context 'a new user visits the site' do
      it 'sets a cookie' do
        expect(cookies[:_pace_url_id]).to be_nil
        get :online, locale: :en
        expect(cookies[:_pace_url_id]).to be_present
        expect(0..1).to cover(cookies[:_pace_url_id])
        expect(assigns(:redirect_string)).to include('nationaldebtline').or include('stepchange')
      end

      it 'responds successfully' do
        expect(response).to be_ok
      end
    end

    context 'a previous user visits the site' do
      it 'does not set the cookie' do
        previous_cookie = rand(2)
        cookies[:_pace_url_id] = previous_cookie
        get :online, locale: :en
        expect(cookies[:_pace_url_id]).to equal(previous_cookie)
      end
    end
  end
end
