module ToolMountPoint
  class MortgageCalculator < Base
    ADDITIONAL_TOOLS = {
      'cy' => {
        'stamp-duty-calculator'             => 'cyfrifiannell-treth-stamp',
        'mortgage-affordability-calculator' => 'cyfrifiannell-fforddiadwyedd-morgais'
      },
      'en' => {
        'cyfrifiannell-treth-stamp'            => 'stamp-duty-calculator',
        'cyfrifiannell-fforddiadwyedd-morgais' => 'mortgage-affordability-calculator'
      }
    }

    def alternate_tool_id(current_tool_id)
      {
        'mortgage-calculator'   => 'cyfrifiannell-morgais',
        'cyfrifiannell-morgais' => 'mortgage-calculator',
        'house-buying'          => 'prynu-ty',
        'prynu-ty'              => 'house-buying'
      }.fetch(current_tool_id)
    end

    def alternate_url(url, locale = nil)
      return url if locale.nil?
      ADDITIONAL_TOOLS[locale].keys.each do |calculator_name|
        if url.include?(calculator_name)
          return url.gsub(calculator_name, translated_calculator_name(locale, calculator_name))
        end
      end
      url
    end

    private

    def translated_calculator_name(locale, calculator_name)
      ADDITIONAL_TOOLS[locale][calculator_name]
    end
  end
end
