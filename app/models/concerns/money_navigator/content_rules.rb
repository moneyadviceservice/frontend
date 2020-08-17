class MoneyNavigator::ContentRules

  #The data representation of the logic that triggers content being displayed
  #Format:
  # [
  #   {
  #     section_code: <Section Code>,
  #     headings: [ <this is the list of headings and their associated content plus triggers as exampled below>
  #       {
  #         heading_code: <header code>,
  #        content:
  #        [<this is the list of content that can appear under a heading. Usually just one article >
  #          {
  #            triggers: [
  #               < a list of the QA combinations whose state triggers display of the content >
  #             ],
  #             masks: [
  #               <A list bitmasks that determins whether the triggers turn the header on or off
  #               each list element must contain as many flags as there are triggers and if any one of these masks
  #               matches the triggers then the content will be displayed>
  #             ],
  #             article: <The CMS URL of the content affected >
  #         }
  #       ]
  #     }
  #   }
  # ]
  #
  # This is effectively a list of section rules.
  # - Each section rule ismade up of a list of heading rules.
  # - Each heading rule is made up of a list of content rules
  # - Each content rule contains
  #   - a list of triggers that produce a 1,0 state depending on whether they are activated or not by the answers (AND logic)
  #   - a mask that is applied to the concatenated result states of the individual triggers (OR logic)
  #   - the content to display if the mask agrees with the state of the triggers
  # which in turn have heading rules
  #
  #NB. the length of the mask: value below should equal the length of the triggers though that requirement is not enforced for additional flexibility
  #If it is shorter then the extra trigers are disregarded
  #e.g with 2 elements in the trigger array generating '11' meaning they are both triggered.
  #the following masks produce the specified content rule outcome
  #- '1' - the content is displayed but only the first mask output is considered i.e (results the same for '11' and '10' output of the triggers)
  #- '0' - the content is displayed only if the first trigger is not pulled irrespective of the state of the other i.e (results the same for '01' and '00' output of the triggers)
  #- '10' - the content is displayed only if the first trigger is pulled and the second is not i.e (results are '10')
  #- '01' - the content is displayed only if the second trigger is pulled and the first is not i.e (results are '01')
  #- '11' - the content is displayed only if both triggers are pulled i.e (results are '11')
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
      MoneyNavigator::Rules::ProtectYourFuture.all,
    ]
  end
end
