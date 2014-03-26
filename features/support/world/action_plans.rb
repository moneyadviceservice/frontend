module World
  module ActionPlans
    def current_action_plan_in(locale)
      case locale
        when 'en'
          @current_action_plan_en ||= build(:action_plan,
            id:          'boost-your-pension-near-retirement',
            title:       'Action plan - Boost your pension near retirement',
            description: 'Practical advice on how to boost your pension plan including deferring retirement and paying more into your pension scheme.',
            body:        'The closer you get to retirement, the less room for manoeuvre you have in terms of filling any gap in your pension savings. But there may still be steps you can take to help generate the kind of income you hope to retire on.')
        when 'cy'
          @current_action_plan_cy ||= build(:action_plan,
            id:          'rhoi-hwb-ich-pensiwn-yn-agos-at-eich-ymddeoliad',
            title:       'Cynllun gweithredu - Rhoi hwb i’ch pensiwn yn agos at eich ymddeoliad',
            description: 'Cyngor ymarferol ar sut i gynyddu eich cynllun pensiwn gan gynnwys gohirio eich ymddeoliad a thalu rhagor i’ch cynllun pensiwn.',
            body:        'Agosaf yn y byd ydych chi at ymddeol, lleiaf yn y byd o gyfle sydd gennych o ran llenwi unrhyw fwlch yn eich cynilion pensiwn. Ond efallai bod rhai camau y gallwch eu cymryd i helpu creu’r math o incwm yr ydych yn gobeithio ymddeol arno.')
      end
    end
  end
end

World(World::ActionPlans)
