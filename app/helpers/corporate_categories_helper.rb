module CorporateCategoriesHelper
  def category_within_corporate_section?(category)
    category.object.parent_id == 'corporate-home'
  end
end
