RSpec.describe CorporateController, type: :controller do

  let(:corporate) { instance_double(Core::Article, id: 'test', categories: []) }
  let(:corporate_reader) { instance_double(Core::CorporateReader, call: corporate) }
  let(:category_tree) { double }
  let(:corporate_category) { Core::Category.new('corporate-home') }
  let(:corporate_category_reader) { instance_double(Core::CategoryReader, call: corporate_category) }

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
      before do
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
end
