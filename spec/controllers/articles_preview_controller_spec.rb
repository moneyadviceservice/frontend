require_relative './shared_examples/get_article'

RSpec.describe ArticlesPreviewController, :type => :controller do
  describe 'GET show' do
    context 'when preview exists for an article' do
      before do
        expect(Core::ArticlePreviewer).to receive(:new) do
          double(Core::ArticlePreviewer, call: article)
        end
      end

      it_should_behave_like 'a successful get article request'
    end

    context 'when preview does not exist for an article' do
      before { allow_any_instance_of(Core::ArticlePreviewer).to receive(:call).and_yield }

      it_should_behave_like 'an unsuccessful get article request'
    end
  end
end
