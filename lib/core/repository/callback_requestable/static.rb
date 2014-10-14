module Core
  module Repository
    module CallbackRequestable
      class Static
        attr_reader :object

        def initialize(object)
          @object = object
        end

        def call
          ids.include?(object.id)
        end

        private

        def ids
          ['managing-your-money-if-your-job-is-at-risk',
           'redundancy-pay',
           'changing-your-career-following-redundancy',
           'claiming-a-tax-rebate-after-losing-your-job',
           'out-of-work-checklist-things-to-do-if-you-lose-your-job',
           'review-your-budget-after-a-drop-in-income',
           'making-the-most-of-your-redundancy-pay',
           'benefits-and-tax-credits-when-youve-lost-your-job',
           'your-pension-options-if-youre-made-redundant',
           'do-you-have-to-pay-tax-on-your-redundancy-payout',
           'top-tips-for-making-money-when-faced-with-job-loss',
           'can-you-insure-yourself-against-redundancy',
           'working-reduced-hours-as-an-alternative-to-redundancy',
           'your-legal-rights-when-facing-redundancy',
           'redundancy-versus-unfair-dismissal',
           'considering-voluntary-redundancy',
           'considering-early-retirement-instead-of-redundancy',
           'what-to-do-about-debt-if-you-lose-your-job',
           'making-or-reviewing-your-will-after-someone-dies',
           'coping-with-debt-after-your-partner-dies',
           'claiming-bereavement-and-other-benefits-after-someone-dies',
           'coping-with-a-drop-in-household-income-after-your-partner-dies',
           'dealing-with-the-debts-of-someone-who-has-died',
           'when-should-you-use-a-probate-specialist',
           'calculating-and-paying-tax-after-someone-dies',
           'what-to-do-about-someones-pension-when-theyve-died',
           'how-to-work-out-the-value-of-someones-estate',
           'paying-for-a-funeral',
           'funeral-plans',
           'how-much-does-a-funeral-cost',
           'pension-and-retirement-planning-following-a-bereavement',
           'coping-with-grief-when-someone-dies',
           'reviewing-your-insurance-after-a-bereavement',
           'what-to-do-when-someone-dies-a-checklist',
           'reviewing-your-savings-and-investments-after-a-bereavement',
           'making-the-most-of-your-inheritance',
           'sorting-out-someones-estate-where-to-start',
           'protect-your-financial-position-during-divorce-or-separation',
           'get-professional-help-with-your-divorce-or-separation',
           'what-to-do-about-a-mortgage-during-separation',
           'dividing-up-what-you-own-during-separation',
           'temporary-or-interim-maintenance-agreements',
           'sorting-out-a-business-during-divorce',
           'sorting-out-a-business-during-separation-from-your-partner',
           'your-home-and-your-divorce-settlement',
           'what-to-do-about-the-home-you-rent-during-separation',
           'arranging-child-maintenance-with-your-ex-partner',
           'insuring-child-maintenance-after-divorce-or-separation',
           'splitting-pensions-during-divorce',
           'maintenance-payments-for-a-spouse-or-civil-partner',
           'changes-to-circumstances-that-can-affect-maintenance',
           'new-relationships-and-maintenance-payments',
           'dealing-with-financial-abuse-when-separating-or-divorcing',
           'paying-divorce-costs',
           'splitting-up-what-you-own-during-divorce',
           'child-trust-funds-and-childrens-savings']
        end
      end
    end
  end
end
