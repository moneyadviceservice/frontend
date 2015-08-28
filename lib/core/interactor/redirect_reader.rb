module Core
  class RedirectReader
    attr_accessor :id

    def initialize(id)
      self.id = id
    end

    def call
      repository.find(id)
    rescue Core::Repository::CMS::Resource301Error,
           Core::Repository::CMS::Resource302Error => e
      yield OpenStruct.new(status: e.status, location: e.location, redirect?: true)
    end

    private

    def repository
      Registry::Repository[:cms_api]
    end
  end
end
