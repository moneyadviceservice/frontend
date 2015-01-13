module Core
  class VideoReader
    attr_reader :id

    def initialize(id)
      @id = id
    end

    def call
      data  = repository.find(id)
      video = Video.new(id, data)

      if video.valid?
        video.tap do |v|
          v.categories = build_categories(v.categories)
        end
      elsif block_given?
        yield
      end
    end

    private

    def repository
      Registry::Repository[:video]
    end

    def build_categories(category_ids)
      category_ids.map do |category_id|
        CategoryReader.new(category_id).call
      end
    end
  end
end
