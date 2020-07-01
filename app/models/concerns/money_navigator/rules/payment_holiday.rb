class MoneyNavigator::Rules::PaymentHoliday
  include MoneyNavigator::Constants

  def self.all
    {
      #'Payment Holidays' section
      section_code: 'S2',
      heading_rules: [

        {
          #'Mortgage payment holidays' Rules
          heading_code: 'H1',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a1'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-mortgage-payment-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a1'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-mortgage-payment-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a1'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-mortgage-payment-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a1'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-mortgage-payment-no-change"
            },
          ]
        },

        {
          #'Personal loan payment holidays' Rules
          heading_code: 'H2',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a2'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-personal-loan-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a2'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-personal-loan-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a2'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-personal-loan-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a2'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-personal-loan-no-change"
            },
          ]
        },

        {
          #'Credit card payment holidays' Rules
          heading_code: 'H3',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a3'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-credit-card-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a3'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-credit-card-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a3'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-credit-card-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a3'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-credit-card-no-change"
            },
          ]
        },

        {
          #'Store card payment holidays' Rules
          heading_code: 'H4',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a4'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-store-card-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a4'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-store-card-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a4'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-store-card-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a4'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-store-card-no-change"
            },
          ]
        },

        {
          #'Car finance payment holidays' Rules
          heading_code: 'H5',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a5'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-car-finance-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a5'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-car-finance-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a5'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-car-finance-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a4'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-car-finance-no-change"
            },
          ]
        },

        {
          #'Buy now pay later payment holidays (eg Klarma)' Rules
          heading_code: 'H6',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a6'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-buy-now-pay-later-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a6'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-buy-now-pay-later-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a6'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-buy-now-pay-later-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a6'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-buy-now-pay-later-no-change"
            },
          ]
        },

        {
          #'Rent to own payment holidays' Rules
          heading_code: 'H7',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a7'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-rent-to-own-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a7'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-rent-to-own-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a7'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-rent-to-own-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a7'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-rent-to-own-no-change"
            },
          ]
        },

        {
          #'Payday loan payment holidays' Rules
          heading_code: 'H8',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a8'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-payday-loan-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a8'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-payday-loan-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a8'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-payday-loan-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a8'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-payday-loan-no-change"
            },
          ]
        },

        {
          #'Pawnbroker payment holidays' Rules
          heading_code: 'H9',
          content_rules: [
            {
              triggers: [
                {q4:'a1', q8:'a9'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-pawnbroker-severe"
            },
            {
              triggers: [
                {q4:'a2', q8:'a9'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-pawnbroker-temp-worried"
            },
            {
              triggers: [
                {q4:'a3', q8:'a9'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-pawnbroker-temp-normal"
            },
            {
              triggers: [
                {q4:'a4', q8:'a9'}
              ] ,
              mask: [ MASK_ALL ],
              article: "coronavirus-holiday-pawnbroker-no-change"
            },
          ]
        },

      ]
    }
  end
end
