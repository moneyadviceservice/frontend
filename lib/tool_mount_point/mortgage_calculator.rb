module ToolMountPoint
  class MortgageCalculator < Base
    def alternate_tool_id(current_tool_id)
      {
        'mortgage-calculator'   => 'cyfrifiannell-morgais',
        'cyfrifiannell-morgais' => 'mortgage-calculator',
        'house-buying'          => 'prynu-ty',
        'prynu-ty'              => 'house-buying',
      }.fetch(current_tool_id)
    end
  end
end
