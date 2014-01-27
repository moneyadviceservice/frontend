module RepositoryRegistry
  extend self

  Error = Class.new(StandardError)

  def []=(type, repository)
    repositories[type] = repository
  end

  def [](type)
    repositories.fetch(type) do
      raise Error, "Repository `%s' not registered" % type
    end
  end

  private

  def repositories
    @repositories ||= {}
  end
end
