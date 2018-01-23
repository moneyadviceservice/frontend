RSpec.describe PageFeedbacksController, type: :controller do
  let(:article) { Mas::Cms::Article.new('understanding-your-payslip') }
  let(:article_no_feedback) { Mas::Cms::Article.new('baby-costs-calculator') }

  before do
    allow(Mas::Cms::Article).to receive(:find)
      .with(article_no_feedback.id, locale: I18n.locale)
      .and_return(article_no_feedback)

    allow(Mas::Cms::Article).to receive(:find)
      .with(article.id, locale: I18n.locale)
      .and_return(article)
  end

  describe '#create' do
    describe 'when the article accepts feedback' do
      describe 'and the feedback is valid' do
        let(:params) do
          {
            session_id: "abc",
            locale: I18n.locale,
            article_id: article.id,
            liked: true
          }
        end

        it 'returns 201 create resource status' do
          post :create, params
          expect(response.status).to be(201)
          body = JSON.parse(response.body)
          expect(body.liked).to be_true
        end
      end

      describe 'but the feedback is not valid' do
        let(:params) do
          {
            locale: I18n.locale,
            article_id: article.id,
            shared_on: 'the moon',
          }
        end

        it 'returns 422 unprocessable entity' do
          post :create, params
          expect(response.status).to be(422)
        end
      end
    end

    describe 'but the article does not accept feedback' do
      let(:params) do
        {
          locale: I18n.locale,
          article_id: article_no_feedback.id,
          liked: true
        }
      end

      it 'returns 403 not allowed' do
        post :create, params
        expect(response.status).to be(403)
      end
    end
  end

  xdescribe '#update' do
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
