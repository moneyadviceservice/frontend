class MoneyNavigator::Rules::MoneyAndWork
  include MoneyNavigator::Constants

  def self.all
    {
      #'Money and work' section
      section_code: 'S4',
      heading_rules: [

        {
          #' Managing your money when you’re self employed ' Rules
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                {q1:'a2'}
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-managing-self-employed"
            },
          ]
        },

        {
          #'Urgent help if you're self employed' Rules
          heading_code: 'H2',
          content_rules: [
            {
              triggers: [
                {q0: ['a1', 'a3', 'a4']},
                {q1: 'a2', q4: 'a1'},
              ],
              mask: [ MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL  ],
              article: "coronavirus-urgent-help-self-employed"
            },
            {
              triggers: [
                {q0: 'a2'},
                {q1: 'a2', q4: 'a1'},
              ],
              mask: [ MASK_ALL + MASK_ALL ],
              article: "coronavirus-urgent-help-self-employed-ni"
            },
          ]
        },

        {
          #' Preparing for redundancy ' Rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                {q1: 'a1'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-preparing-redundancy"
            },
          ]
        },

        {
          #' What to do if you`re unemployed' Rules
          heading_code: 'H4',
          content_rules: [
            {
              triggers: [
                {q1: 'a3'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-unemployed"
            },
          ]
        },

      ]
    }
  end
end
