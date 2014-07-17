RSpec.describe Authentication, :type => :controller do
  let(:session) { {} }

  controller do
    include Authentication

    public :user_signed_in?

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
end
