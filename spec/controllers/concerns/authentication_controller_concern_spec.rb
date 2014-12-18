RSpec.describe Authentication, type: :controller do
  controller do
    include Authentication

    public :user_signed_in?
    public :store_location

    def index
      head :ok
    end
  end

  before do
    get :index, {}, session
  end

  context 'when the session does not contain authentication details' do
    specify { expect(controller.user_signed_in?).to be_falsey }
  end

  context 'when the session contains authentication details' do
    let(:session) { { 'warden.user.user.key' => 'details' } }

    specify { expect(controller.user_signed_in?).to be_truthy }
  end

  context 'store location' do
    let(:my_path) { '/mypath' }

    before do
      allow(request).to receive(:fullpath) { my_path }
    end

    it 'stores the request path when standard' do
      controller.store_location
      expect(session[:user_return_to]).to eq(my_path)
    end

    it 'does not store the request path for ajax requests' do
      allow(request).to receive(:xhr?) { true }
      controller.store_location
      expect(session[:user_return_to]).to_not eq(my_path)
    end
  end
end
