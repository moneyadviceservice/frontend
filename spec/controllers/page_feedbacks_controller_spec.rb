RSpec.describe PageFeedbacksController, type: :controller do
  describe 'POST /page_feedbacks' do
    describe 'when valid' do
      let(:page_feedback) do
        Core::PageFeedback.new(liked: true)
      end

      before do
        expect_any_instance_of(Core::PageFeedbackCreator)
          .to receive(:call).and_return(page_feedback)
        post :create, {
            locale: I18n.locale,
            article_id: 'contact-us',
            liked: true
          },
          {
            id: '53c70fc632fb7382f93da5012d8083e1'
          }
      end

      it 'returns 201 create resource status' do
        expect(response.status).to be(201)
      end
    end

    describe 'when invalid' do
      before do
        expect_any_instance_of(Core::PageFeedbackCreator)
          .to receive(:call).and_return(false)
        post :create, { locale: I18n.locale, article_id: 'contact-us' }
      end

      it 'returns unprocessable entity' do
        expect(response.status).to be(422)
      end
    end
  end
end
