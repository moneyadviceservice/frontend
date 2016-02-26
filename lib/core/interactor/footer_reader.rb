module Core
  class FooterReader < BaseContentReader
    private

    def entity_class
      Footer
    end

    def repository
      Registry::Repository[:footer]
    end
  end
end
