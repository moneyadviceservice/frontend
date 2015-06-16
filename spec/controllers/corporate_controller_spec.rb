RSpec.describe CorporateController, type: :controller, features: [:corporate_tool_directory] do
  let(:corporate) { instance_double(Core::Article, id: 'test', categories: []) }
  let(:corporate_reader) { instance_double(Core::CorporateReader, call: corporate) }
  let(:category_tree) { double.as_null_object }
  let(:corporate_category) { Core::Category.new('corporate-home', contents: []) }
  let(:syndication_category) { Core::Category.new('syndication', contents: []) }
  let(:corporate_category_reader) { instance_double(Core::CategoryReader, call: corporate_category) }
  let(:syndication_category_reader) { instance_double(Core::CategoryReader, call: syndication_category) }

  before do
    allow(Core::CategoryTreeReader).to receive(:new) do
      instance_double(Core::CategoryTreeReader, call: category_tree)
    end
  end

  describe "GET index" do
    before do
      allow(Core::CategoryReader).to receive(:new) do
        instance_double(Core::CategoryReader, call: corporate_category)
      end
    end

    context 'when corporate-home category exists' do
      before do
        expect(Core::CategoryReader).to receive(:new).with(corporate_category.id) { corporate_category_reader }
        get :index, locale: I18n.locale
      end

      it "responds successfully" do
        expect(response).to be_ok
      end

      it "assigns category" do
        expect(assigns[:category]).to be(corporate_category)
      end
    end
  end

  describe 'GET show' do
    context 'when corporate page exists' do
      let(:corporate) { instance_double(Core::Article, id: 'test', categories: [corporate_category]) }

      before do
        expect(Core::CategoryReader).to receive(:new).with(corporate_category.id) { corporate_category_reader }
        expect(Core::CategoryReader).to receive(:new).with(syndication_category.id) { syndication_category_reader }
        expect(Core::CorporateReader).to receive(:new).with(corporate.id) { corporate_reader }
        get :show, locale: I18n.locale, id: corporate.id
      end

      it 'responds successfuly' do
        expect(response).to be_ok
      end

      it 'assigns corporate page' do
        expect(assigns[:article]).to be(corporate)
      end
    end

    context 'when corporate page does not exist' do
      it 'raises an ActionController RoutingError' do
        allow(Core::CorporateReader).to receive(:new) { ->(&block) { block.call } }

        expect { get :show, id: 'foo', locale: I18n.locale }.to raise_error(ActionController::RoutingError)
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
