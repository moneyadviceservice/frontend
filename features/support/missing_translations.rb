module FlagMissingTranslations
  @missing_translations_should_fail = false
  @missing_translations = []

  class << self
    include Capybara::DSL

    def format_missing_translations(missing_translations = @missing_translations)
      missing_translations.flatten.map do |translation|
        key = translation[:title].split(': ').last
        "Missing Translation: #{key}"
      end.uniq
    end

    def missing_translations_should_fail?
      @missing_translations_should_fail
    end

    def after_scenario
      translation_missing_elems = all('.translation_missing').to_a
      if translation_missing_elems.any?
        @missing_translations << translation_missing_elems

        if missing_translations_should_fail?
          fail format_missing_translations(translation_missing_elems).join("\n")
        end
      end
    end

    def at_exit
      if @missing_translations.any?
        formatted_missing_translations = format_missing_translations

        $stderr.puts "\n"
        $stderr.puts '-------------------------------------------------------------'.color(:cyan)
        $stderr.puts "There are #{formatted_missing_translations.length} untranslated strings. Please check your locales:".color(:cyan)
        $stderr.puts '-------------------------------------------------------------'.color(:cyan)
        $stderr.puts "\n"
        $stderr.puts formatted_missing_translations.join("\n").color(:red)
        $stderr.puts "\n"
      end
    end
  end
end

After { FlagMissingTranslations.after_scenario }
at_exit { FlagMissingTranslations.at_exit }
