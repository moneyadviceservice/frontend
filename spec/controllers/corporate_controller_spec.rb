RSpec.describe CorporateController, type: :controller do
  let(:syndication_category) { Mas::Cms::Category.new('syndication', contents: []) }
  let(:corporate_category) { Mas::Cms::Category.new('corporate-home', contents: []) }

  before do
    allow(Mas::Cms::Category).to receive(:find)
    .with('corporate-home', locale: I18n.locale)
    .and_return(corporate_category)

    allow(Mas::Cms::Category).to receive(:find)
    .with('syndication', anything)
    .and_return(syndication_category)
  end

  describe 'GET index' do
    context 'when corporate-home category exists' do
      before do
        get :index, locale: I18n.locale
      end

      it 'responds successfully' do
        expect(response).to be_ok
      end

      it 'assigns category' do
        expect(assigns[:category]).to be(corporate_category)
      end
    end
  end

  describe 'GET show' do
    context 'when corporate page exists' do
      let(:corporate_article) { Mas::Cms::Article.new('test', categories: [corporate_category]) }

      before do
        allow(Mas::Cms::Article).to receive(:find)
        .with(corporate_article.id, locale: I18n.locale)
        .and_return(corporate_article)

        get :show, locale: I18n.locale, id: corporate_article.id
      end

      it 'responds successfuly' do
        expect(response).to be_ok
      end

      it 'assigns corporate page' do
        expect(assigns[:article]).to be(corporate_article)
      end
    end
  end

  describe 'POST create' do
    let(:tool) { instance_double(Core::Article, id: "#{valid_partner[:tool_name]}", categories: [syndication_category]) }
    let(:valid_partner)   { FactoryGirl.attributes_for(:corporate_partner, tool_name: 'budget-planner-syndication') }
    let(:invalid_partner) { { name: 2323, width: 'sasd' } }

    context 'with valid attributes' do
      it 'creates a new partner' do
        expect do
          post :create, locale: I18n.locale, corporate_partner: valid_partner, id: tool.id
        end.to change(CorporatePartner, :count).by(1)
      end

      it 'responds successfuly' do
        expect(response).to be_ok
      end
    end

    context 'with valid attributes and a partner record already exists' do

      before do
        post :create, locale: I18n.locale, corporate_partner: valid_partner, id: tool.id
      end

      it 'updates existing partner record' do
        expect do
          post :create, locale: I18n.locale, corporate_partner: valid_partner, id: tool.id
        end.to_not change(CorporatePartner, :count)
        expect(CorporatePartner.count).to eq(1)
      end

    end

    context 'with invalid attributes' do
      it 'does not save the new partner' do
        expect do
          post :create, locale: I18n.locale, corporate_partner: invalid_partner, id: tool.id
        end.to_not change(CorporatePartner,:count)
      end

      it 're-renders the corporate tool page' do
        post :create, locale: I18n.locale, corporate_partner: invalid_partner, id: tool.id
        expect(response).to render_template('corporate/show')
      end
    end
  end

  describe 'tool friendly name' do
    it 'formats the slug correctly' do
      allow(subject).to receive(:params) do
        { id: 'my-long-tool-name-syndication' }
      end

      result = subject.send(:tool_friendly_name);
      expect(result).to eq('My long tool name')
    end
  end
end
