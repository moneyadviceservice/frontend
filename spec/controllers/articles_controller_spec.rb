require_relative './shared_examples/get_article'

RSpec.describe ArticlesController, :type => :controller do
  describe 'GET show' do
    context 'when an article does exist' do
      before do
        expect(Core::ArticleReader).to receive(:new) do
          double(Core::ArticleReader, call: article)
        end
      end

      it_should_behave_like 'a successful get article request'
    end

    context 'when an article does not exist' do
      before { allow_any_instance_of(Core::ArticleReader).to receive(:call).and_yield }

      it_should_behave_like 'an unsuccessful get article request'
    end
  end
end
