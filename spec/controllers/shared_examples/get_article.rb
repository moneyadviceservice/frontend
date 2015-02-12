RSpec.shared_examples 'a successful get article request' do
  before do
    allow(BreadcrumbTrail).to receive(:build) { breadcrumbs }

    allow(Core::CategoryTreeReader).to receive(:new) do
      instance_double(Core::CategoryTreeReader, call: category_tree)
    end
    expect(BreadcrumbTrail).to receive(:build).with(article, category_tree)
    get :show, id: article.id, locale: I18n.locale, page_type: 'articles'
  end

  let(:article) { Core::Article.new('test', categories: categories) }
  let(:categories) { [] }
  let(:breadcrumbs) { [] }
  let(:category_tree) { double }

  it 'returns success response' do
    expect(response).to be_ok
  end

  it 'assigns the result of article reader to @article' do
    expect(assigns(:article)).to eq(article)
  end

  it 'assigns the breadcrumbs to @breadcrumbs' do
    expect(assigns(:breadcrumbs)).to eq(breadcrumbs)
  end
end

RSpec.shared_examples 'an unsuccessful get article request' do
  it 'raises an ActionController RoutingError' do
    expect { get :show, id: 'does-not-exist', locale: I18n.locale, page_type: 'articles' }
        .to raise_error(ActionController::RoutingError)
  end
end
