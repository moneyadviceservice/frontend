class MoneyNavigator::Rules::UrgentAction
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Urgent Actions' section
      section_code: 'S1',
      heading_rules: [

        {
          # Get Free debt advice now' Rules
          # Any of these Q4A1, Q4A2, Q6A4, Q6A5, Q6A6, Q7A1-A9  BUT NOT IF HAVE SELECTED Q10A1 PLUS the regional variation
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                { q0: 'a1' },
                { q6: %w[a1 a2 a3 a4 a5 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9], q9: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11]},
                { q1: 'a2' }
              ],
              mask: [MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE],
              article: 'coronavirus-debt-advice-england'
            },
            {
              triggers: [
                { q0: 'a2' },
                { q6: %w[a1 a2 a3 a4 a5 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9], q9: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11]},
                { q1: 'a2'}
              ],
              mask: [MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE],
              article: 'coronavirus-debt-advice-ni'
            },
            {
              triggers: [
                { q0: 'a3' },
                { q6: %w[a1 a2 a3 a4 a5 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9], q9: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11]},
                { q1: 'a2'}
              ],
              mask: [MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE],
              article: 'coronavirus-debt-advice-scotland'
            },
            {
              triggers: [
                { q0: 'a4' },
                { q6: %w[a1 a2 a3 a4 a5 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9], q9: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9 a10 a11]},
                { q1: 'a2'}
              ],
              mask: [MASK_ALL + MASK_SOME + MASK_NONE, MASK_ALL + MASK_ALL + MASK_NONE],
              article: 'coronavirus-debt-advice-wales'
            }
          ]
        },

        {
          # 'SELF EMPLOYED DEBT ADVICE Contact Business Debtline for England' heading rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                { q0: %w[a1 a3 a4] },
                { q1: ['a2'] },
                { q3: ['a2']},
                { q4: %w[a1 a2 a3], q6: %w[a4 a5 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9] },
                { q3: ['a1'] }
              ],
              mask: [MASK_SOME + MASK_ALL + MASK_ALL + MASK_SOME + MASK_NONE,
                     MASK_ALL + MASK_ALL + MASK_ALL + MASK_SOME + MASK_NONE,
                     MASK_SOME + MASK_ALL + MASK_ALL+ MASK_ALL + MASK_NONE,
                     MASK_ALL + MASK_ALL + MASK_ALL + MASK_ALL + MASK_NONE
              ],
              article: 'coronavirus-self-employed-debt-advice'
            },

            {
              triggers: [
                { q0: ['a2'] },
                { q1: ['a2'] },
                { q3: ['a2'] },
                { q4: %w[a1 a2 a3], q6: %w[a4  a6 a6], q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9] },
                { q3: ['a1'] }
              ],
              mask: [
                MASK_ALL + MASK_ALL + MASK_ALL + MASK_SOME + MASK_NONE,
                MASK_ALL + MASK_ALL + MASK_ALL + MASK_ALL + MASK_NONE
              ],
              article: 'coronavirus-self-employed-debt-advice-ni'
            }
          ]
        },

        {
          # 'Pensions content' heading rules
          heading_code: 'H4',
          content_rules: [
            {
              triggers: [
                { q12: ['a2'] }
              ],
              mask: [MASK_ALL],
              article: 'urgent-pension-advice'
            }

          ]
        },

        {
          # 'Mental Health CTA' heading rules
          heading_code: 'H5',
          content_rules: [
            {
              triggers: [
                { q0: %w[a1 a2 a3] },
                { q14: ['a3'] }
              ],
              mask: [MASK_SOME + MASK_ALL],
              article: 'coronavirus-help-mental-health-sometimes'
            },

            {
              triggers: [
                { q0: ['a4'] },
                { q14: ['a3'] }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-help-mental-health-sometimes-wales'
            },

            {
              triggers: [
                { q0: ['a1'] },
                { q14: ['a1'] }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-help-mental-health-england'
            },

            {
              triggers: [
                { q0: ['a2'] },
                { q14: ['a1'] }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-help-mental-health-ni'
            },

            {
              triggers: [
                { q0: ['a3'] },
                { q14: ['a1'] }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-help-mental-health-scotland'
            },

            {
              triggers: [
                { q0: ['a4'] },
                { q14: ['a1'] }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-help-mental-health-wales'
            }
          ]
        }
      ]
    }
  end
end
