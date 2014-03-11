module World
  module Categories
    def populate_category_repository_with(*categories)
      repository = Core::Repositories::Categories::Fake.new(*categories)
      Core::Registries::Repository[:category] = repository
    end

    def category_with_2_levels_of_subcategory
      @category_with_2_levels_of_subcategory ||= build(:category_hash, contents: [
        build(:category_hash, contents: build_list(:category_hash, 2)),
        build(:category_hash, contents: build_list(:category_hash, 2))
      ])
    end

    def category_containing_only_content
      @category_containing_only_content ||= build(:category_hash, contents: [
        build(:article_hash), build(:action_plan_hash)])
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
