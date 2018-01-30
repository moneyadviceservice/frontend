RSpec.describe PageFeedbacksController, type: :controller do
  let(:article) { Mas::Cms::Article.new('understanding-your-payslip') }
  let(:article_no_feedback) do
    Mas::Cms::Article.new(
      'baby-costs-calculator',
      slug: 'baby-costs-calculator'
    )
  end

  before do
    allow(Mas::Cms::Article).to receive(:find)
      .with(article_no_feedback.id, locale: I18n.locale)
      .and_return(article_no_feedback)

    allow(Mas::Cms::Article).to receive(:find)
      .with(article.id, locale: I18n.locale)
      .and_return(article)
  end
  let(:params) do
    {
      locale: I18n.locale,
      article_id: article.id
    }
  end
  let(:create_params) { params.merge(liked: true) }
  let(:update_params) { params.merge(shared_on: 'Email') }

  context 'when the article accepts feedback' do
    context 'and the feedback is valid' do
      describe '#create' do
        it 'returns 201 create resource status' do
          post :create, create_params
          expect(response.status).to eq(201)
          body = JSON.parse(response.body)
          expect(body['liked']).to be true
        end
      end
      describe '#update' do
        it 'returns 200 status' do
          post :create, create_params
          post :update, update_params
          expect(response.status).to eq(200)
        end
      end
    end
  end
  context 'when error occours processing the request' do
    before do
      allow(Mas::Cms::PageFeedback).to receive(:create)
        .and_raise(Mas::Cms::Errors::UnprocessableEntity)
    end

    it 'returns a 422 error' do
      post :create, create_params
      expect(response.status).to eq(422)
    end
  end
  context 'the article does not accept feedback' do
    let(:params) do
      {
        locale: I18n.locale,
        article_id: article_no_feedback.id,
        liked: true
      }
    end

    it 'returns 403 not allowed' do
      post :create, params
      expect(response.status).to eq(403)
    end
  end
end
