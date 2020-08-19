class MoneyNavigator::Rules::NonPriorityBills
  include MoneyNavigator::Constants

  def self.all
    {
      #'Staying on top of non-priority bills' section
      section_code: 'S7',
      heading_rules: [

        {
          #'Personal loan payments' Rules
          heading_code: 'H1',
          content_rules: [
            #Q9A1, Q4A1 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-personal-loan-severe"
            },
            #Q9A1, Q4A2 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-personal-loan-temp-worried"
            },
            #Q9A1, Q4A3 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-personal-loan-temp-normal"
            },
            #Q9A1, Q4A4 HIDE IF Q8A2 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a1' },
                {q8: 'a2'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-personal-loan-no-change"
            },
          ]
        },

        {
          #'Water bill' Rules
          heading_code: 'H2',
          content_rules: [
            #Q9A2, Q4A1
            {
              triggers: [
                {q4: 'a1', q9: 'a2'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-water-severe"
            },
            #Q9A2, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a2'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-water-temp-worried"
            },
            #Q9A2, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a2'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-water-temp-normal"
            },
            #Q9A2, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a2'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-water-no-change"
            },
          ]
        },

        {
          #'Mobile phone, TV or broadband' Rules
          heading_code: 'H3',
          content_rules: [
            #Q8A3, Q4A1
            {
              triggers: [
                {q4: 'a1', q9: 'a3'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-mobile-tv-broadband-severe"
            },
            #Q9A3, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a3'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-mobile-tv-broadband-temp-worried"
            },
            #Q9A3, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a3'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-mobile-tv-broadband-temp-normal"
            },
            #Q9A3, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a3'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-mobile-tv-broadband-no-change"
            },
          ]
        },

        {
          #'Credit card payments' Rules
          heading_code: 'H4',
          content_rules: [
            #Q9A4, Q4A1 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-credit-card-severe"
            },
            #Q9A4, Q4A2 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-credit-card-temp-worried"
            },
            #Q9A4, Q4A3 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-credit-card-temp-normal"
            },
            #Q9A4, Q4A4 HIDE IF Q8A3 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a4'},
                {q8: 'a3'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-credit-card-no-change"
            },
          ]
        },

        {
          #'Store card payments' Rules
          heading_code: 'H5',
          content_rules: [
            #Q9A5, Q4A1 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-store-card-severe"
            },
            #Q9A5, Q4A2 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-store-card-temp-worried"
            },
            #Q9A5, Q4A3 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-store-card-temp-normal"
            },
            #Q9A5, Q4A4 HIDE IF Q8A4 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a5'},
                {q8: 'a4'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-store-card-no-change"
            },
          ]
        },

        {
          #'Car finance payments' Rules
          heading_code: 'H6',
          content_rules: [
            #Q9A6, Q4A1 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-car-finance-severe"
            },
            #Q9A6, Q4A2 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-car-finance-temp-worried"
            },
            #Q9A6, Q4A3 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-car-finance-temp-normal"
            },
            #Q9A6, Q4A4 HIDE IF Q8A5 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a6'},
                {q8: 'a5'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-car-finance-no-change"
            },
          ]
        },

        {
          #'Buy now pay later payments (eg Klarma)' Rules
          heading_code: 'H7',
          content_rules: [
            #Q9A7, Q4A1 HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-buy-now-pay-later-severe"
            },
            #Q9A7, Q4A2  HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-buy-now-pay-later-temp-worried"
            },
            #Q9A7, Q4A3  HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-buy-now-pay-later-temp-normal"
            },
            #Q9A7, Q4A4 HIDE IF Q8A6 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a7'},
                {q8: 'a6'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-buy-now-pay-later-no-change"
            },
          ]
        },

        {
          #'Rent to own payments' Rules
          heading_code: 'H8',
          content_rules: [
            #Q9A8, Q4A1 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-rent-to-own-severe"
            },
            #Q9A8, Q4A2 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-rent-to-own-temp-worried"
            },
            #Q9A8, Q4A3 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-rent-to-own-temp-normal"
            },
            #Q9A8, Q4A4 HIDE IF Q8A7 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a8'},
                {q8: 'a7'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-rent-to-own-no-change"
            },
          ]
        },

        {
          #'Payday loan payments' Rules
          heading_code: 'H9',
          content_rules: [
            #Q9A9, Q4A1 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-payday-loan-severe"
            },
            #Q9A9, Q4A2 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-payday-loan-temp-worried"
            },
            #Q9A9, Q4A3 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-payday-loan-temp-normal"
            },
            #Q9A9, Q4A4 HIDE IF Q8A8 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a9'},
                {q8: 'a8'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-payday-loan-no-change"
            },
          ]
        },

        {
          #'Pawnbroker payments' Rules
          heading_code: 'H10',
          content_rules: [
            #Q9A10, Q4A1 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a1', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-pawnbroker-severe"
            },
            #Q9A10, Q4A2 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a2', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-pawnbroker-temp-worried"
            },
            #Q9A10, Q4A3 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a3', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-pawnbroker-temp-normal"
            },
            #Q9A10, Q4A4 HIDE IF Q8A9 CHECKED
            {
              triggers: [
                {q4: 'a4', q9: 'a10'},
                {q8: 'a9'},
              ],
              mask: [ MASK_ALL + MASK_NONE ],
              article: "coronavirus-pawnbroker-no-change"
            },
          ]
        },

        {
          #'Payments to family and friends' Rules
          heading_code: 'H11',
          content_rules: [
            #Q9A11, Q4A1
            {
              triggers: [
                {q4: 'a1', q9: 'a11'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-friends-family-severe"
            },
            #Q9A11, Q4A2
            {
              triggers: [
                {q4: 'a2', q9: 'a11'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-friends-family-temp-worried"
            },
            #Q9A11, Q4A3
            {
              triggers: [
                {q4: 'a3', q9: 'a11'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-friends-family-temp-normal"
            },
            #Q9A11, Q4A4
            {
              triggers: [
                {q4: 'a4', q9: 'a11'},
              ],
              mask: [ MASK_ALL ],
              article: "coronavirus-friends-family-no-change"
            },
          ]
        },

      ]
    }
  end
end
