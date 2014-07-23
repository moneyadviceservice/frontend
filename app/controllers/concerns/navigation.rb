module Navigation
  extend ActiveSupport::Concern

  included do
    helper_method :active_categories
    before_action :clear_active_categories
  end

  private

  attr_reader :active_categories

  def assign_active_categories(*categories)
    categories.each do |category|
      active_category category.id
      active_category category.parent_id if category.child?
    end
  end

  def active_category(category_id)
    @active_categories << category_id
  end

  def clear_active_categories
    @active_categories = []
  end
end
