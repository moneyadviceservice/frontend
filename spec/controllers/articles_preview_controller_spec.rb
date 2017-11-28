require_relative './shared_examples/get_article'

RSpec.describe ArticlesPreviewController, type: :controller do
  def attributes
    {
      id: article.id,
      locale: I18n.locale,
      page_type: 'articles'
    }
  end

  describe 'GET show' do
    context 'when article exists' do
      before { get :show, attributes }
      let(:article) { double(id: 'how-much-rent-can-you-afford') }

      it { is_expected.to respond_with 200 }
    end

    context 'when article does not exist' do
      let(:article) { double(id: 'fake-article') }

      it 'returns resource not found error' do
        expect{
          get :show, attributes
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
