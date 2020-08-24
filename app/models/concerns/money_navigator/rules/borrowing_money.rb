class MoneyNavigator::Rules::BorrowingMoney
  include MoneyNavigator::Constants

  def self.all
    {
      # 'Borrowing money' section
      section_code: 'S8',
      heading_rules: [
        {
          # 'If you are thinking of borrowing money' Rules
          heading_code: 'H1',
          content_rules: [
            # Q11A1, Q4A1
            {
              triggers: [
                { q4: 'a1', q11: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-thinking-of-borrowing-severe'
            },
            # Q11A1, Q4A2
            {
              triggers: [
                { q4: 'a2', q11: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-thinking-of-borrowing-temp-worried'
            },
            # Q11A1, Q4A3
            {
              triggers: [
                { q4: 'a3', q11: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-thinking-of-borrowing-temp-normal'
            },
            # Q11A1, Q4A4
            {
              triggers: [
                { q4: 'a4', q11: 'a1' }
              ],
              mask: [MASK_ALL],
              article: 'coronavirus-thinking-of-borrowing-no-change'
            }
          ]
        }
      ]
    }
  end
end
