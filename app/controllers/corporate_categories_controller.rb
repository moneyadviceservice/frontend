class CorporateCategoriesController < CategoriesController
  def show
    super
    @category = Core::CorporateCategory.new(@category.id, @category.attributes)
  end
end
