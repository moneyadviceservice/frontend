class MoneyNavigator::Rules::MentalHealth
  include MoneyNavigator::Constants

  def self.all
    {
      #'Money worries and mental health' section
      section_code: 'S11',
      heading_rules: [
        {
          #' If money worries are affecting your mental health ' Rules
          heading_code: 'H1',
          content_rules: [
            #Q14A1 or Q14A2
            {
              triggers: [
                {q14: ['a1', 'a3']},
              ],
              mask: [ MASK_SOME, MASK_ALL  ],
              article: "coronavirus-mental-health"
            },
          ]
        },

      ]
    }
  end
end
