class MoneyNavigator::Rules::ProtectYourFuture
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Protecting your future' section
      section_code: 'S10',
      heading_rules: [
        {
          # ' If you’re thinking about cancelling insurance ' Rules
          heading_code: 'H1',
          content_rules: [
            # Q13A1 or Q13A2
            {
              triggers: [
                { q13: %w[a1 a3] }
              ],
              mask: [MASK_SOME, MASK_ALL],
              article: 'coronavirus-cancelling-insurance'
            }
          ]
        }

      ]
    }
  end
end
