module World
  module Categories
    def current_category
      Core::Registries::Repository[:category].all.first
    end
  end
end

World(World::Categories)
