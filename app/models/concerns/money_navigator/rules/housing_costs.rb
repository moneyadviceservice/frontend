class MoneyNavigator::Rules::HousingCosts
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Staying on top of housing costs' section
      section_code: 'S5',
      heading_rules: [

        {
          # 'If you`ve missed one mortgage or rent payment' Rules
          # Q6A4 or Q6A5 or Q6A6 HIDE IF Q4A4 CHECKED
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                { q6: %w[a4 a5 a6] },
                { q4: 'a4' }
              ],
              mask: [MASK_SOME + MASK_NONE, MASK_ALL + MASK_NONE],
              article: 'missed-rent-mortgage-low'
            }
          ]
        },

        {
          # ' If you’re worried about rent payments (renting privately)' Rules
          heading_code: 'H2',
          content_rules: [
            {
              triggers: [
                { q0: 'a1', q6: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-private-england'
            },
            {
              triggers: [
                { q0: 'a2', q6: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-private-ni'
            },
            {
              triggers: [
                { q0: 'a3', q6: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-private-scotland'
            },
            {
              triggers: [
                { q0: 'a4', q6: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-private-wales'
            }
          ]
        },

        {
          # ' If you’re worried about rent payments (social housing' Rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                { q0: 'a1', q6: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-social-england'
            },
            {
              triggers: [
                { q0: 'a2', q6: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-social-ni'
            },
            {
              triggers: [
                { q0: 'a3', q6: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-social-scotland'
            },
            {
              triggers: [
                { q0: 'a4', q6: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-rent-social-wales'
            }
          ]
        },

        {
          # ' If you’re worried about mortgage payments ' Rules
          heading_code: 'H4',
          content_rules: [
            {
              triggers: [
                { q0: 'a1', q6: 'a3' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-mortgage-payments'
            },
            {
              triggers: [
                { q0: 'a2', q6: 'a3' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-mortgage-payments'
            },
            {
              triggers: [
                { q0: 'a3', q6: 'a3' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-mortgage-payments-scotland'
            },
            {
              triggers: [
                { q0: 'a4', q6: 'a3' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-mortgage-payments-wales'
            }
          ]
        },

        {
          # 'If you’re behind with rent payments because of COVID-19' Rules
          heading_code: 'H5',
          content_rules: [
            {
              triggers: [
                { q0: 'a1', q6: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-behind-rent-england'
            },
            {
              triggers: [
                { q0: 'a2', q6: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-behind-rent-ni'
            },
            {
              triggers: [
                { q0: 'a3', q6: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-behind-rent-scotland'
            },
            {
              triggers: [
                { q0: 'a4', q6: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-behind-rent-wales'
            }
          ]
        },

        {
          # 'If you’re behind with mortgage payments because of COVID-19' Rules
          heading_code: 'H6',
          content_rules: [
            {
              triggers: [
                { q0: 'a1', q6: 'a5' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-behind-mortgage'
            },
            {
              triggers: [
                { q0: 'a2', q6: 'a5' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-behind-mortgage'
            },
            {
              triggers: [
                { q0: 'a3', q6: 'a5' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-behind-mortgage-scotland'
            },
            {
              triggers: [
                { q0: 'a4', q6: 'a5' },
                { q8: 'a1' }
              ],
              mask: [MASK_ALL + MASK_NONE],
              article: 'coronavirus-behind-mortgage-wales'
            }
          ]
        }

      ]
    }
  end
end
