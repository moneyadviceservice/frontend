class CorporateController < ArticlesController
  decorates_assigned :article, with: CorporateDecorator
  decorates_assigned :category, with: CategoryDecorator

  before_filter :assign_categories
  def index
  end

  private

  def interactor
    Core::CorporateReader.new(params[:id])
  end

  def category_tree(categories)
    Core::CategoryTreeReader.new.call(categories)
  end

  def assign_categories
    @category = Core::CategoryReader.new('corporate-home').call
    assign_active_categories(@category)
  end
end
