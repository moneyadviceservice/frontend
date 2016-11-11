RSpec.describe PageFeedbacksController, type: :controller do
  let(:page_feedback) { Core::PageFeedback.new(liked: true) }
  let(:article) { double }

  before do
    allow(Core::Article).to receive(:new) { article }
  end

  describe 'POST /page_feedbacks' do
    let(:creator) { double }
    let(:params) do
      {
        locale: I18n.locale,
        article_id: 'contact-us',
        liked: true
      }
    end

    before do
      allow(Core::PageFeedbackCreator).to receive(:new) { creator }
    end

    describe 'when the article accepts feedback' do
      before do
        allow(article).to receive(:accepts_feedback?) { true }
      end

      describe 'and the feedback is valid' do
        before do
          allow(creator).to receive(:call) { page_feedback }
        end

        it 'calls the creator' do
          expect(creator).to receive(:call)
          post :create, params
        end

        it 'returns 201 create resource status' do
          post :create, params
          expect(response.status).to be(201)
        end
      end

      describe 'but the feedback is not valid' do
        before do
          allow(creator).to receive(:call) { false }
        end

        it 'calls the creator' do
          expect(creator).to receive(:call)
          post :create, params
        end

        it 'returns 422 unprocessable entity' do
          post :create, params
          expect(response.status).to be(422)
        end
      end
    end

    describe 'but the article does not accept feedback' do
      before do
        allow(article).to receive(:accepts_feedback?) { false }
      end

      it 'returns 403 not allowed' do
        post :create, params
        expect(response.status).to be(403)
      end
    end
  end

  describe 'PATCH /en/articles/example-article/page_feedbacks' do
    let(:updator) { double }
    let(:params) do
      {
        'shared_on'  => 'Twitter',
        'locale'     => :en,
        'article_id' => 'example-article',
        'comment'    => 'Feedback comment'
      }
    end

    before do
      allow(Core::PageFeedbackUpdator).to receive(:new) { updator }
    end

    describe 'when the article accepts feedback' do
      before do
        allow(article).to receive(:accepts_feedback?) { true }
      end

      context 'and the feedback is valid' do
        before do
          allow(updator).to receive(:call) { page_feedback }
        end

        it 'calls the updator' do
          expect(updator).to receive(:call)
          patch :update, params
        end

        it 'returns 200 success response' do
          patch :update, params
          expect(response.status).to be(200)
        end
      end

      context 'but the feedback is not valid' do
        before do
          allow(updator).to receive(:call) { false }
        end

        it 'calls the updator' do
          expect(updator).to receive(:call)
          patch :update, params
        end

        it 'returns 422 unprocessable entity' do
          patch :update, params
          expect(response.status).to be(422)
        end
      end
    end

    describe 'but the article does not accept feedback' do
      before do
        allow(article).to receive(:accepts_feedback?) { false }
      end

      it 'returns 403 not allowed' do
        patch :update, params
        expect(response.status).to be(403)
      end
    end
  end
end
