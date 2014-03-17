module Core
  class RepositoryCache
    attr_accessor :repository, :cache

    def initialize(repository, cache)
      @repository, @cache = repository, cache
    end

    def all
      cache.fetch("#{I18n.locale}-#{repository.class}-all") do
        repository.all
      end
    end

    def find(id)
      cache.fetch("#{I18n.locale}-#{repository.class}-find-#{id}") do
        repository.find(id)
      end
    end
  end
end
