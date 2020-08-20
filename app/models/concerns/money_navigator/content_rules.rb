class MoneyNavigator::ContentRules
  # This method returns an array of oall the content rules for each section within the system (i.e. each elementof the array contains the rules for a given section)
  # An array element will have the following format:
  #
  # [
  #   {
  #     section_code: <Section Code>,
  #     headings_rules: [ <this is the list of headings and their associated content plus triggers as exampled below>
  #       {
  #         heading_code: <header code>,
  #         content_rules:
  #           [<this is the list of content that can appear under a heading. Usually just one article >
  #           {
  #              triggers: [
  #                 < a list of the QA combinations whose state triggers display of the content >
  #               ],
  #               masks: [
  #                 <A list bitmasks that determins whether the trigger for this content will be fired or not >
  #               ],
  #               article: <The CMS URL of the content affected >
  #         }
  #       ]
  #     }
  #   }
  # ]
  # This is effectively a list of section rules.
  # - Each section rule ismade up of a list of heading rules.
  # - Each heading rule is made up of a list of content rules
  # - Each content rule contains
  #   - a list of triggers that produce a 1,0 state depending on whether they are activated or not by the answers (AND logic)
  #   - a mask that is applied to the concatenated result states of the individual triggers (OR logic)
  #   - the content to display if the mask agrees with the state of the triggers
  # which in turn have heading rules
  #
  #
  def self.all
    [
      MoneyNavigator::Rules::UrgentAction.all,
      MoneyNavigator::Rules::HousingCosts.all,
      MoneyNavigator::Rules::MentalHealth.all,
      MoneyNavigator::Rules::BorrowingMoney.all,
      MoneyNavigator::Rules::MoneyAndWork.all,
      MoneyNavigator::Rules::MovingForward.all,
      MoneyNavigator::Rules::NonPriorityBills.all,
      MoneyNavigator::Rules::PaymentHoliday.all,
      MoneyNavigator::Rules::PensionsEquitySavings.all,
      MoneyNavigator::Rules::PriorityBills.all,
      MoneyNavigator::Rules::ProtectYourFuture.all
    ]
  end
end
