class MoneyNavigator::Rules::MovingForward
  include MoneyNavigator::Constants

  def self.all
    {
      #'Your money moving forward ' section
      section_code: 'S3',
      heading_rules: [

        {
          #'Getting back on track after an income drop ' Rules
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                {q4:'a1'}
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-back-on-track-severe"
            },
          ]
        },

        {
          #'Getting back on track after a severe income drop' Rules
          heading_code: 'H2',
          content_rules: [
            {
              triggers: [
                {q4: ['a2', 'a3']}
              ],
              mask: [ MASK_SOME, MASK_ALL  ],
              article: "coronavirus-back-on-track"
            },
          ]
        },

        {
          #'Looking forward after the COVID pandemic' Rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                {q4: 'a4'}
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-looking-forward"
            },
          ]
        },

      ]
    }
  end
end
