module Core
  class VideoPreviewer < VideoReader
    private

    def repository
      Registry::Repository[:preview]
    end
  end
end
