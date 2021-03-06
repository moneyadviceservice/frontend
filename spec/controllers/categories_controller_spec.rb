RSpec.describe CategoriesController, type: :controller do
  describe 'GET show' do
    let(:category) { Mas::Cms::Category.new('test') }

    context 'when the category exists' do
      before do
        allow(Mas::Cms::Category).to receive(:find)
          .with(category.id, locale: I18n.locale)
          .and_return(category)

        get :show, id: category.id, locale: I18n.locale
      end

      it 'is successful' do
        expect(response).to be_ok
      end

      it 'assigns @category to the result of category reader' do
        expect(assigns(:category)).to eq(category)
      end

      it 'assigns @breadcrumbs to the result of breadcrumb reader' do
        expect(assigns(:breadcrumbs).map(&:path)).to eq(['/en'])
      end
    end
  end
end
