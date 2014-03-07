module World
  module Categories
    def populate_category_repository_with(*categories)
      repository = Core::Repositories::Categories::Fake.new(*categories)
      Core::Registries::Repository[:category] = repository
    end

    def current_category
      @current_category ||= build(:category_hash, contents: build_list(:category_hash, 2))
    end
  end
end

World(World::Categories)
