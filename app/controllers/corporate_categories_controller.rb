class CorporateCategoriesController < CategoriesController
  decorates_assigned :category, with: CorporateCategoryDecorator

  def show
    super

    set_article
  end

  private

  def article_interactor
    Core::CorporateReader.new(default_article_id)
  end

  def set_article
    @article = article_interactor.call do
      not_found
    end
    @article = ContentItemDecorator.new(@article)
  end

  def default_article_id
    category.contents.first.id
  end
end
