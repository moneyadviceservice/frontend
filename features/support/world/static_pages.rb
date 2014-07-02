module World
  module StaticPages
    def static_page_id_for_locale(locale)
      case locale
      when 'en'
        'privacy'
      when 'cy'
        'polisipreifatrwydd'
      end
    end

    def static_page_for_locale(locale)
      id = static_page_id_for_locale(locale)
      I18n.with_locale(locale) do
        Core::StaticPageReader.new(id).call
      end
    end
  end
end

World(World::StaticPages)
