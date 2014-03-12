module World
  module Categories
    def populate_category_repository_with(*categories)
      repository = Core::Repositories::Categories::Fake.new(*categories)
      Core::Registries::Repository[:category] = repository
    end

    def category_containing_no_child_categories
      @category_containing_no_child_categories ||= build(:category_hash, :content_items)
    end

    def category_containing_child_categories
      @category_containing_child_categories ||= build(:category_hash, contents:
        build_list(:category_hash, 2, :content_items))
    end

    def category_containing_child_and_grandchild_categories
      @category_containing_child_and_grandchild_categories ||= build(:category_hash, contents: [
        build(:category_hash, contents: build_list(:category_hash, 2, :content_items)),
        build(:category_hash, contents: build_list(:category_hash, 2, :content_items)),
      ])
    end

    def browse_to_category(category)
      category_page.load(locale: :en, id: category['id'])
      @current_category = category
    end

    def current_category
      @current_category
    end
  end
end

World(World::Categories)
