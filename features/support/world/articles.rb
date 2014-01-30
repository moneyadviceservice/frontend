module World
  module Articles
    def current_article
      @current_article ||=  build(:article)
    end
  end
end

World(World::Articles)
