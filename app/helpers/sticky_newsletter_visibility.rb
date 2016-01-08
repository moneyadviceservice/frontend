module StickyNewsletterVisibility
  class StickyNewsletterFilter
    BLACKLIST_FILTERED = ['',
                          'categories',
                          'corporate',
                          'tools',
                          'videos',
                          'corporate_categories',
                          'sitemap',
                          'users',
                          'campaigns/survive-january'
                         ]

    BLACKLIST_ARTICLES = %w(
      making-or-reviewing-your-will-after-someone-dies
      coping-with-debt-after-your-partner-dies
      claiming-bereavement-and-other-benefits-after-someone-dies
      coping-with-a-drop-in-household-income-after-your-partner-dies
      dealing-with-the-debts-of-someone-who-has-died
      when-should-you-use-a-probate-specialist
      calculating-and-paying-tax-after-someone-dies
      what-to-do-about-someones-pension-when-theyve-died
      how-to-work-out-the-value-of-someones-estate
      paying-for-a-funeral
      funeral-plans
      how-much-does-a-funeral-cost
      pension-and-retirement-planning-following-a-bereavement
      coping-with-grief-when-someone-dies
      reviewing-your-insurance-after-a-bereavement
      what-to-do-when-someone-dies-a-checklist
      reviewing-your-savings-and-investments-after-a-bereavement
      making-the-most-of-your-inheritance
      taking-over-the-budget-after-your-partner-dies
      sorting-out-someones-estate-where-to-start
      help-manage-the-money-of-someone-youre-caring-for
      support-services-available-to-carers
      financial-support-for-young-carers
      benefits-and-tax-credits-you-can-claim-as-a-carer
      when-does-someone-need-formal-help-with-managing-their-money
      help-someone-informally-with-budgeting-and-day-to-day-money
      if-the-person-you-want-to-help-can-still-manage-their-money
      if-the-person-you-want-to-help-has-lost-mental-capacity
      how-to-sort-out-your-money-if-you-become-ill-or-disabled
      support-to-help-you-keep-your-job-when-ill-or-disabled
      help-to-find-work-if-youre-disabled
      support-to-help-you-study-when-ill-or-disabled
      disability-and-sickness-benefits-check-your-entitlements
      personal-independence-payment-an-introduction
      universal-credit-for-disabled-people
      financial-support-if-you-or-your-child-has-a-disability
      how-to-appeal-against-a-disability-benefits-decision
      funding-to-adapt-your-home-for-accessibility
      charitable-grants-for-ill-or-disabled-people
      shopping-around-for-disability-aids-and-equipment
      motability-blue-badge-scheme-and-discounted-travel
      money-saving-tips-and-discounts-for-disabled-people
      support-to-help-you-study-when-ill-or-disabled
      getting-a-mortgage-if-youre-ill-or-disabled
      getting-a-loan-if-you-are-ill-or-disabled
      early-retirement-because-of-illness-or-disability
      buying-insurance-if-youre-ill-or-disabled
      long-term-care-services-at-a-glance
      planning-ahead-for-when-you-cant-manage-your-money
      care-services-to-help-you-stay-in-your-own-home
      preparing-for-illness-old-age-and-death
      care-home-or-home-care
      choosing-the-right-care-home
      what-if-youre-unhappy-with-the-care-you-receive
      how-to-challenge-your-local-authority-over-your-care
      solving-problems-when-family-members-are-helping-with-your-money
      using-a-personal-assistant-to-provide-your-care
      when-does-someone-need-formal-help-with-managing-their-money
      setting-up-a-power-of-attorney
      setting-up-a-trust
      being-a-trustee
      resolving-problems-with-attorneys-and-trustees
      self-funding-your-long-term-care-your-options
      are-you-eligible-for-nhs-continuing-care-funding
      benefits-you-can-claim-when-you-have-care-needs
      get-financial-advice-on-how-to-fund-your-long-term-care
      local-authority-funding-for-care-costs-do-you-qualify
      registered-nursing-care-contribution
      means-tests-for-help-with-care-costs-how-they-work
      how-a-local-authority-care-needs-assessment-works
      direct-payments-explained
      managing-direct-payments-to-pay-for-the-care-you-need
      how-to-fund-your-long-term-care-a-beginners-guide
      claiming-on-insurance-to-help-cover-the-costs-of-care
      using-a-home-reversion-plan-to-pay-for-your-care
      make-your-money-easier-to-manage-by-yourself
      using-investment-bonds-to-pay-for-your-long-term-care
      immediate-need-care-fee-payment-plans
      using-a-lifetime-mortgage-to-pay-for-your-long-term-care
      using-an-equity-release-scheme-to-fund-your-care
      paying-your-own-care-costs-but-the-moneys-run-out
      downsizing-your-home-to-fund-your-long-term-care
      if-your-baby-is-stillborn
      if-the-person-you-want-to-help-has-lost-mental-capacity
      putting-your-affairs-in-order
      preparing-for-illness-old-age-and-death
      choosing-your-executor
      if-you-have-had-a-late-miscarriage
      if-your-baby-has-died-shortly-after-birth
    )

    def initialize(slug)
      @slug = slug
    end

    def blacklist_page?
      blacklist_filter_results.any? || blacklist_article?
    end

    private

    def blacklist_filter_results
      BLACKLIST_FILTERED.map do |pattern|
        if pattern.empty?
          '/en' == @slug || '/cy' == @slug
        else
          /\/(en|cy)\/#{pattern}/i.match(@slug)
        end
      end
    end

    def blacklist_article?
      @slug.gsub(/\/en\/articles\//, '').in?(BLACKLIST_ARTICLES)
    end
  end

  def display_sticky_newsletter?
    slug = request.url.gsub(request.base_url, '')
    !StickyNewsletterFilter.new(slug).blacklist_page?
  end
end
