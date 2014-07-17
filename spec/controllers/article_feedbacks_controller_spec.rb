RSpec.describe ArticleFeedbacksController, :type => :controller do
  let(:article_id) { 'article-id' }
  let(:article) { double(id: article_id) }

  describe 'GET new' do
    it 'is successful' do
      get :new, article_id: article.id, locale: I18n.locale

      expect(response).to be_ok
    end
  end

  describe 'POST create' do
    let(:feedback_writer) { double }
    let(:feedback_entity) { double }
    let(:feedback_params) { double }

    before do
      allow(controller).to receive(:feedback_params) { feedback_params }
      allow(controller).to receive(:article) { article }
      allow(Core::Feedback::Article).to receive(:new) { feedback_entity }
      allow(Core::FeedbackWriter).to receive(:new) { feedback_writer }
      allow(feedback_writer).to receive(:call)
    end

    it 'creates an article feedback entity' do
      expect(Core::Feedback::Article).to receive(:new).with(feedback_params)

      post :create, article_id: article.id, locale: I18n.locale
    end

    it 'creates a new feedback writer with the entity' do
      expect(Core::FeedbackWriter).to receive(:new).with(feedback_entity)

      post :create, article_id: article.id, locale: I18n.locale
    end

    it 'calls the writer' do
      expect(Core::FeedbackWriter).to receive(:new).with(feedback_entity)

      post :create, article_id: article.id, locale: I18n.locale
    end

    context 'when the writer call is successful' do
      it 'sets the flash appropriately' do
        post :create, article_id: article.id, locale: I18n.locale
        expect(flash[:success]).to eq(I18n.t('article_feedbacks.create.flash_notice'))
      end

      it 'redirects back to the article' do
        post :create, article_id: article.id, locale: I18n.locale
        expect(response).to redirect_to(article_path(id: article.id, locale: I18n.locale))
      end
    end

    context 'when the writer call is not successful' do
      before { allow(feedback_writer).to receive(:call).and_yield }

      it 'renders the new form' do
        post :create, article_id: article.id, locale: I18n.locale
        expect(response).to render_template(:new)
      end
    end
  end
end
