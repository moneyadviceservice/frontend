module World
  module Categories
    def populate_category_repository_with(*categories)
      repository = Core::Repositories::Categories::Fake.new(*categories)
      Core::Registries::Repository[:category] = repository
    end

    def category_with_2_levels_of_subcategory
      @current_category = build(:category_hash, contents:[
        build(:category_hash, contents: build_list(:category_hash, 2)),
        build(:category_hash, contents: build_list(:category_hash, 2))
      ])
    end

    def current_category
      @current_category
    end
  end
end

World(World::Categories)
