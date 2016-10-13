RSpec.describe PageFeedbacksController, type: :controller do
  describe 'POST /page_feedbacks' do
    describe 'when valid' do
      it 'returns 201 create resource status' do
        post :create, locale: I18n.locale, article_id: 'contact-us'
        expect(response.status).to be(201)
      end
    end

    describe 'when invalid' do
    end
  end
end
