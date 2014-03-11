module World
  module Pages
    %w(article home action_plan category search_results).each do |page|
      define_method("#{page}_page") do
        "UI::Pages::#{page.camelize}".constantize.new
      end
    end

    def language_to_locale(language)
      { english: 'en', welsh: 'cy' }[language.downcase.to_sym]
    end

    def underscore(name)
      name.tr(' ', '_')
    end

  end
end

World(World::Pages)
