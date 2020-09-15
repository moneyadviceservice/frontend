class MoneyNavigator::Rules::PriorityBills
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Staying on top of priority bills' section
      section_code: 'S6',
      heading_rules: [

        {
          # 'If you`ve missed one payment' Rules
          # Q7A1 or Q7A2 or Q7A3 or Q7A4 or Q7A5 or Q7A6 or Q7A7 or Q7A8 or Q7A9
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                { q7: %w[a1 a2 a3 a4 a5 a6 a7 a8 a9] }
              ],
              mask: [MASK_SOME, MASK_ALL],
              article: 'missed-payment-low'
            }
          ]
        },

        {
          # 'What to do about paying your Council Tax (Domestic Rates Northern Ireland)' Rules
          heading_code: 'H2',
          content_rules: [
            {
              # Q7A1, Q4A1 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                { q0: %w[a1 a3 a4] },
                { q7: 'a1', q4: 'a1' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-council-tax-severe'
            },
            {
              # Q7A1, Q4A1, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a1', q4: 'a1' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-domestic-rates-severe'
            },
            {
              # Q7A1, Q4A2 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                { q0: %w[a1 a3 a4] },
                { q7: 'a1', q4: 'a2' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-council-tax-temp-worried'
            },
            {
              # Q7A1, Q4A2, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a1', q4: 'a2' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-domestic-rates-temp-worried'
            },
            {
              # Q7A1, Q4A3 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                { q0: %w[a1 a3 a4] },
                { q7: 'a1', q4: 'a3' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-council-tax-temp-normal'
            },
            {
              # Q7A1, Q4A4, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a1', q4: 'a3' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-domestic-rates-temp-normal'
            },
            {
              # Q7A1, Q4A4 and Q0A1 or Q0A3 or Q0A4
              triggers: [
                { q0: %w[a1 a3 a4] },
                { q7: 'a1', q4: 'a4' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-council-tax-no-change'
            },
            {
              # Q7A1, Q4A4, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a1', q4: 'a4' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-domestic-rates-no-change'
            }
          ]
        },

        {
          # 'What to do about paying your gas or electricity bill' Rules
          heading_code: 'H3',
          content_rules: [
            {
              # Q7A2, Q4A1
              triggers: [
                { q7: 'a2', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-gas-electricity-severe'
            },
            {
              # Q7A2, Q4A2
              triggers: [
                { q7: 'a2', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-gas-electricity-temp-worried'
            },
            {
              # Q7A2, Q4A3
              triggers: [
                { q7: 'a2', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-gas-electricity-temp-normal'
            },
            {
              # Q7A2, Q4A4
              triggers: [
                { q7: 'a2', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-gas-electricity-no-change'
            }
          ]
        },

        {
          # 'What to do about payments to DWP/HMRC' Rules
          heading_code: 'H4',
          content_rules: [
            {
              # Q7A3, Q4A1
              triggers: [
                { q7: 'a3', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-dmp-hmrc-severe'
            },
            {
              # Q7A3, Q4A2
              triggers: [
                { q7: 'a3', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-dmp-hmrc-temp-worried'
            },
            {
              # Q7A3, Q4A3
              triggers: [
                { q7: 'a3', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-dmp-hmrc-temp-normal'
            },
            {
              # Q7A3, Q4A4
              triggers: [
                { q7: 'a3', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-dmp-hmrc-no-change'
            }
          ]
        },

        {
          # 'What to do about paying your TV Licence' Rules
          heading_code: 'H5',
          content_rules: [
            {
              # Q7A4, Q4A1
              triggers: [
                { q7: 'a4', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-tv-licence-severe'
            },
            {
              # Q7A4, Q4A2
              triggers: [
                { q7: 'a4', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-tv-licence-temp-worried'
            },
            {
              # Q7A4, Q4A3
              triggers: [
                { q7: 'a4', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-tv-licence-temp-normal'
            },
            {
              # Q7A4, Q4A4
              triggers: [
                { q7: 'a4', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-tv-licence-no-change'
            }
          ]
        },

        {
          # 'What to do about paying your Income Tax bill' Rules
          heading_code: 'H6',
          content_rules: [
            {
              # Q7A5, Q4A1
              triggers: [
                { q7: 'a5', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-income-tax-severe'
            },
            {
              # Q7A5, Q4A2
              triggers: [
                { q7: 'a5', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-income-tax-temp-worried'
            },
            {
              # Q7A5, Q4A3
              triggers: [
                { q7: 'a5', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-income-tax-temp-normal'
            },
            {
              # Q7A5, Q4A4
              triggers: [
                { q7: 'a5', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-income-tax-no-change'
            }
          ]
        },

        {
          # 'What to do about paying your child maintenance ' Rules
          heading_code: 'H7',
          content_rules: [
            {
              # Q7A6, Q4A1
              triggers: [
                { q7: 'a6', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-child-maintenance-severe'
            },
            {
              # Q7A6, Q4A2
              triggers: [
                { q7: 'a6', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-child-maintenance-temp-worried'
            },
            {
              # Q7A6, Q4A3
              triggers: [
                { q7: 'a6', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-child-maintenance-temp-normal'
            },
            {
              # Q7A6, Q4A4
              triggers: [
                { q7: 'a6', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-child-maintenance-no-change'
            }
          ]
        },

        {
          # 'What to do about paying court fines' Rules
          heading_code: 'H8',
          content_rules: [
            {
              # Q7A7, Q4A1 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a7', q4: 'a1' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-severe'
            },
            {
              # Q7A7, Q4A1, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a7', q4: 'a1' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-severe-ni'
            },
            {
              # Q7A7, Q4A1, Q0A3
              triggers: [
                { q0: ['a3'] },
                { q7: 'a7', q4: 'a1' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-severe-scotland'
            },
            {
              # Q7A7, Q4A2 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a7', q4: 'a2' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-worried'
            },
            {
              # Q7A7, Q4A2, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a7', q4: 'a2' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-worried-ni'
            },
            {
              # Q7A7, Q4A2, Q0A3
              triggers: [
                { q0: ['a3'] },
                { q7: 'a7', q4: 'a2' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-worried-scotland'
            },
            {
              # Q7A7, Q4A3 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a7', q4: 'a3' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-normal'
            },
            {
              # Q7A7, Q4A4, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a7', q4: 'a3' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-normal-ni'
            },
            {
              # Q7A7, Q4A4, Q0A3
              triggers: [
                { q0: ['a3'] },
                { q7: 'a7', q4: 'a3' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-temp-normal-scotland'
            },
            {
              # Q7A7, Q4A4 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a7', q4: 'a4' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-no-change'
            },
            {
              # Q7A7, Q4A4, Q0A2
              triggers: [
                { q0: ['a2'] },
                { q7: 'a7', q4: 'a4' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-no-change-ni'
            },
            {
              # Q7A7, Q4A4, Q0A3
              triggers: [
                { q0: ['a3'] },
                { q7: 'a7', q4: 'a4' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-court-fines-no-change-scotland'
            }
          ]
        },

        {
          # 'What to do about hire purchase agreements' Rules
          heading_code: 'H9',
          content_rules: [
            {
              # Q7A8, Q4A1
              triggers: [
                { q7: 'a8', q4: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-hire-purchase-severe'
            },
            {
              # Q7A8, Q4A2
              triggers: [
                { q7: 'a8', q4: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-hire-purchase-temp-worried'
            },
            {
              # Q7A8, Q4A3
              triggers: [
                { q7: 'a8', q4: 'a3' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-hire-purchase-temp-normal'
            },
            {
              # Q7A8, Q4A4
              triggers: [
                { q7: 'a8', q4: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-hire-purchase-no-change'
            }
          ]
        },

        {
          # 'What to do about car parking fines?' Rules
          heading_code: 'H10',
          content_rules: [
            {
              # Q7A9, Q4A1 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a9', q4: 'a1' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-severe'
            },
            {
              # Q7A9, Q4A1, Q0A2
              triggers: [
                { q0: 'a2' },
                { q7: 'a9', q4: 'a1' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-severe-ni'
            },
            {
              # Q7A9, Q4A1, Q0A3
              triggers: [
                { q0: 'a3' },
                { q7: 'a9', q4: 'a1' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-severe-scotland'
            },
            {
              # Q7A9, Q4A2 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a9', q4: 'a2' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-worried'
            },
            {
              # Q7A9, Q4A2, Q0A2
              triggers: [
                { q0: 'a2' },
                { q7: 'a9', q4: 'a2' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-worried-ni'
            },
            {
              # Q7A9, Q4A2, Q0A3
              triggers: [
                { q0: 'a3' },
                { q7: 'a9', q4: 'a2' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-worried-scotland'
            },
            {
              # Q7A9, Q4A3 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a9', q4: 'a3' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-normal'
            },
            {
              # Q7A9, Q4A4, Q0A2
              triggers: [
                { q0: 'a2' },
                { q7: 'a9', q4: 'a3' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-normal-ni'
            },
            {
              # Q7A9, Q4A4, Q0A3
              triggers: [
                { q0: 'a3' },
                { q7: 'a9', q4: 'a3' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-temp-normal-scotland'
            },
            {
              # Q7A9, Q4A4 and Q0A1 or Q0A4
              triggers: [
                { q0: %w[a1 a4] },
                { q7: 'a9', q4: 'a4' }
              ],
              mask: [MASK_SOME + MASK_ALL, MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-no-change'
            },
            {
              # Q7A9, Q4A4, Q0A2
              triggers: [
                { q0: 'a2' },
                { q7: 'a9', q4: 'a4' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-no-change-ni'
            },
            {
              # Q7A9, Q4A4, Q0A3
              triggers: [
                { q0: 'a3' },
                { q7: 'a9', q4: 'a4' }
              ],
              mask: [MASK_ALL + MASK_ALL],
              article: 'coronavirus-car-park-no-change-scotland'
            }
          ]
        }

      ]
    }
  end
end
