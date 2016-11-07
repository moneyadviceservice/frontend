RSpec.describe PageFeedbacksController, type: :controller do
  let(:page_feedback) do
    Core::PageFeedback.new(liked: true)
  end

  describe 'POST /page_feedbacks' do
    describe 'when valid' do
      let(:params) do
        {
          locale: I18n.locale,
          article_id: 'contact-us',
          liked: true
        }
      end

      before do
        expect_any_instance_of(Core::PageFeedbackCreator)
          .to receive(:call)
          .with(params.merge(session_id: session.id))
          .and_return(page_feedback)
        post :create, params
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

  describe 'PATCH /en/articles/example-article/page_feedbacks' do
    let(:params) do
      {
        'shared_on'  => 'Twitter',
        'locale'     => :en,
        'article_id' => 'example-article',
        'comment'    => 'Feedback comment'
      }
    end

    context 'when valid' do
      before do
        expect_any_instance_of(Core::PageFeedbackUpdator)
          .to receive(:call)
          .with(params.merge(session_id: session.id))
          .and_return(page_feedback)
        patch :update, params
      end

      it 'returns success response' do
        expect(response.status).to be(200)
      end
    end

    context 'when invalid' do
      before do
        expect_any_instance_of(Core::PageFeedbackUpdator)
          .to receive(:call).and_return(false)
        patch :update, params
      end

      it 'returns success response' do
        expect(response.status).to be(422)
      end
    end
  end
end
