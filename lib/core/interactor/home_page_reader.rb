module Core
  class HomePageReader < BaseContentReader
    private

    def entity_class
      HomePage
    end

    def repository
      Registry::Repository[:home_page]
    end

    def build_categories(category_ids)
      []
    end
  end
end
