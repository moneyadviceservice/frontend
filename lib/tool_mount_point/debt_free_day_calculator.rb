module ToolMountPoint
  class DebtFreeDayCalculator < Base
    class LoanCalculator < Base
      EN_ID = 'loan-calculator'
      CY_ID = 'cyfrifiannell-benthyciadau'
    end

    class CreditCardCalculator < Base
      EN_ID = 'credit-card-calculator'
      CY_ID = 'cyfrifiannell-cerdyn-credyd'
    end

    def initialize
      @loan_calculator_mount_point = LoanCalculator.new
      @credit_card_calculator_mount_point = CreditCardCalculator.new
    end

    def matches?(request)
      (@loan_calculator_mount_point.matches?(request) ||
        @credit_card_calculator_mount_point.matches?(request))
    end

    def alternate_tool_id(tool_id)
      {
        LoanCalculator::EN_ID => LoanCalculator::CY_ID,
        LoanCalculator::CY_ID => LoanCalculator::EN_ID,
        CreditCardCalculator::EN_ID => CreditCardCalculator::CY_ID,
        CreditCardCalculator::CY_ID => CreditCardCalculator::EN_ID
      }.fetch(tool_id)
    end

    def en_id
      unsupported __method__
    end

    def cy_id
      unsupported __method__
    end

    private

    def unsupported(method_name)
      fail("Unsupported: there is no logical implementation of `#{method_name}` for this class")
    end
  end
end
