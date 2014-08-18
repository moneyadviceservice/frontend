RSpec.describe TechnicalFeedbacksController, :type => :controller do
  describe 'GET new' do
    let(:expected_path) { 'return_path' }

    before { allow(request).to receive(:referer) { expected_path } }

    it 'is successful' do
      get :new, locale: I18n.locale

      expect(response).to be_ok
    end

    it 'sets the return path to the current task' do
      get :new, locale: I18n.locale

      expect(session[:return_to]).to eql(expected_path)
    end
  end

  describe 'POST create' do
    let(:feedback_writer) { double }
    let(:feedback_entity) { double }
    let(:feedback_params) { double }
    let(:redirect_path) { 'return_path' }

    before do
      allow(controller).to receive(:feedback_params) { feedback_params }
      allow(Core::Feedback::Technical).to receive(:new) { feedback_entity }
      allow(Core::FeedbackWriter).to receive(:new) { feedback_writer }
      allow(feedback_writer).to receive(:call)
      session[:return_to] = redirect_path
    end

    it 'creates a technical feedback entity' do
      expect(Core::Feedback::Technical).to receive(:new).with(feedback_params)

      post :create, locale: I18n.locale
    end

    it 'creates a new feedback writer with the entity' do
      expect(Core::FeedbackWriter).to receive(:new).with(feedback_entity)

      post :create, locale: I18n.locale
    end

    it 'calls the writer' do
      expect(Core::FeedbackWriter).to receive(:new).with(feedback_entity)

      post :create, locale: I18n.locale
    end

    context 'when the writer call is successful' do
      it 'sets the flash appropriately' do
        post :create, locale: I18n.locale

        expect(flash[:success]).to eq(I18n.t('technical_feedbacks.create.flash_notice'))
      end

      it 'redirects back to the previous page' do
        post :create, locale: I18n.locale

        expect(response).to redirect_to(redirect_path)
      end
    end

    context 'when the writer call is not successful' do
      before { allow(feedback_writer).to receive(:call).and_yield }

      it 'renders the new form' do
        post :create, locale: I18n.locale

        expect(response).to render_template(:new)
      end
    end
  end
end
