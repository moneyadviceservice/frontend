module World
  module Videos
    attr_accessor :video_page

    def browse_to_video_page(language)
      self.video_page = UI::Pages::Video.new
      video_page.load(locale: locale(language), id: video_id(language))
    end

    private

    def locale(language)
      language == 'English' ? 'en' : 'cy'
    end

    def video_id(language)
      language == 'English' ? 'get-ready-universal-credit' : 'paratoi-ar-gyfer-credyd'
    end
  end
end

World(World::Videos)
