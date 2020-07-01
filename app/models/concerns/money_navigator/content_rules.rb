class MoneyNavigator::ContentRules

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
