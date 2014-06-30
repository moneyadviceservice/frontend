module ArticlesHelper
  def category_has_more_content?(article, related_content_category)
    category = article.categories.find { |c| c == related_content_category }
    count = category.try(:contents).try(:count) || 0

    # related content excludes the currently displayed article
    count > (related_content_category.contents.count + 1)
  end
end
