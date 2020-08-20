class MoneyNavigator::Rules::PensionsEquitySavings
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Using pensions, equity and savings' section
      section_code: 'S9',
      heading_rules: [
        {
          # ' If you’re thinking about using your pension pot to pay off debts ' Rules
          heading_code: 'H1',
          content_rules: [
            # Q12A2
            {
              triggers: [
                { q12: 'a2' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-pensions-debt'
            }
          ]
        },

        {
          # ' If you’re thinking about using equity in your home to pay off debts ' Rules
          heading_code: 'H2',
          content_rules: [
            # Q12A1 or Q12A3
            {
              triggers: [
                { q12: %w[a1 a3] }
              ],
              mask: [MASK_SOME, MASK_ALL],
              article: 'coronavirus-equity-mortage-debt'
            }
          ]
        },

        {
          # 'If you're thinking of using your savings to pay off debts' Rules
          heading_code: 'H3',
          content_rules: [
            # Q12A4
            {
              triggers: [
                { q12: 'a4' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-savings-debt'
            }
          ]
        }
      ]
    }
  end
end
