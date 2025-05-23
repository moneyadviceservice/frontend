#= require ./tool_syndication
#= require ./resizer

@masConfig =
  targetSelector: "mas-widget"
  containerClass: "mas-widget-container"
  containerStyles: "width: 100%; margin: 0 auto;"
  en:
    linkClass: "mas-widget-logo-link"
    linkHref: "https://www.moneyhelper.org.uk/en"
    linkTarget: "_blank"
    logoSrc: "https://www.moneyhelper.org.uk/etc.clientlibs/maps/core/clientlibs/clientlib-base/resources/logos/logo-en-desktop.svg"
    logoStyles: "display: block; margin-bottom: 8px; width: 300px"
    logoAltText: "MoneyHelper"
  cy:
    linkClass: "mas-widget-logo-link"
    linkHref: "https://www.moneyhelper.org.uk/cy"
    linkTarget: "_blank"
    logoSrc: "https://www.moneyhelper.org.uk/etc.clientlibs/maps/core/clientlibs/clientlib-base/resources/logos/logo-cy-desktop.svg"
    logoStyles: "display: block; margin-bottom: 8px; width: 300px"
    logoAltText: "HelpwrArian"

  toolConfig:
    employer_best_practices:
      en:
        path: 'en/employer-best-practices/money-guide'
      cy:
        path: 'cy/employer-best-practices/money-guide'
      width: '100%'
      title: 'Making the most of your money'

    baby_timeline:
      en:
        path: "en/tools/baby-money-timeline"
      cy:
        path: "cy/tools/llinell-amser-arian-babi"
      width: "100%"
      title: "Baby money timeline"
      omit_logo: true

    baby_timeline_mumsnet:
      en:
        path: "en/tools/baby-money-timeline?version=mumsnet"
      width: "100%"
      title: "Baby money timeline"
      omit_logo: true

    debt_test:
      en:
        path: "en/tools/debt-test"
      cy:
        path: "cy/tools/prawf-dyledion"
      width: "100%"
      height: "1550px"
      title: "Debt test"

    help_to_buy_quiz:
      en:
        path: "en/quiz/help_to_buy"
      width: "600px"
      height: "2000px"
      title: "Help to buy quiz"

    quiz:
      en:
        path: "en/tools/quiz/widgets/22/start"
      cy:
        path: "cy/tools/quiz/widgets/22/start"
      width: "100%"
      height: "2000px"
      title: "Quiz"

    christmas_planner:
      en:
        path: "en/cost_planner/plans/christmas-syndicated/start"
      cy:
        path: "en/cost_planner/plans/christmas-syndicated/start"
      height: "2400px"
      width: "100%"
      title: "Christmas planner"

    christmas_planner_no_start_page:
      en:
        path: "en/cost_planner/plans/christmas-syndicated"
      width: "100%"
      height: "2400px"
      title: "Christmas planner"

    budget_planner:
      en:
        path: "en/tools/budget-planner"
      cy:
        path: "cy/tools/cynllunydd-cyllideb"
      width: "100%"
      height: "2500px"
      title: "Budget planner"
      omit_logo: true

    budget_planner_incognito:
      en:
        path: "en/tools/budget-planner/incognito"
      cy:
        path: "en/tools/cynllunydd-cyllideb/incognito"
      width: "100%"
      height: "2500px"
      title: "Budget planner"
      omit_logo: true

    back_to_school:
      en:
        path: "en/cost_planner/plans/back-to-school/start"
      width: "100%"
      height: "2100px"
      title: "Back to school"

    divorce_and_separation:
      en:
        path: "divorce_separation_calculator/index.html"
      width: "748px"
      height: "1230"
      title: "Divorce and separation calculator"

    workplace_pensions:
      en:
        path: "workplace_pensions_calculator/index.html"
      cy:
        path: "workplace_pensions_calculator/index.html?lang=cy"
      width: "800px"
      height: "2200px"
      title: "Workplace pensions calculator"

    universal_credit_timeline:
      en:
        path: "universal_credit_timeline/index.html"
      cy:
        path: "universal_credit_timeline/index_cy.html"
      width: "960px"
      height: "700px"
      title: "Universal credit timeline"

    auto_enrolment:
      en:
        path: "en/tools/workplace-pension-advice-tool"
      width: "960px"
      height: "700px"
      title: "Workplace pension advice tool"

    summer_planner:
      en:
        path: "summer_planner/index.html"
      cy:
        path: "summer_planner/index.html?lang=cy"
      height: "1340px"
      width: "720px"
      title: "Summer planner"

    how_much_to_save:
      en:
        path: "how_much_to_save_2013_04_08_en/index.htm"
      cy:
        path: "how_much_to_save_2013_04_08_cy/index.htm"
      height: "700px"
      width: "680px"
      title: "How much to save"

    mortgage_calculator_new:
      en:
        path: "en/tools/mortgage-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-morgais"
      width: "100%"
      omit_logo: true
      title: "Mortgage calculator"

    mortgage_calculator:
      en:
        path: "en/tools/mortgage-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-morgais"
      width: "100%"
      omit_logo: true
      title: "Mortgage calculator"

    stamp_duty:
      en:
        path: "en/tools/house-buying/stamp-duty-calculator"
      cy:
        path: "cy/tools/prynu-ty/cyfrifiannell-treth-stamp"
      omit_logo: true
      title: "Stamp duty calculator"

    lbtt_calculator:
      en:
        path: "en/tools/house-buying/land-and-buildings-transaction-tax-calculator-scotland"
      cy:
        path: "cy/tools/prynu-ty/cyfrifiannell-treth-trafodion-tir-ac-adeiladau-alban"
      width: "100%"
      omit_logo: true
      title: "LBTT Calculator"

    mortgage_affordability_calculator:
      en:
        path: "en/tools/house-buying/mortgage-affordability-calculator"
      cy:
        path: "cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais"
      title: "Mortgage affordability calculator"

    payday_loans_intervention:
      en:
        path: "en/payday-loans"
      cy:
        path: "cy/benthyciadau-diwrnod-cyflog"
      height: "2000px"
      width: "100%"
      omit_logo: true
      title: "Payday loans"

    pensions_calculator:
      en:
        path: "en/tools/pension-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-pensiwn"
      width: "100%"
      height: "800px"
      title: "Pensions calculator"

    pension_calculator:
      en:
        path: "en/tools/pension-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-pensiwn"
      width: "100%"
      height: "800px"
      title: "Pension calculator"

    health_check:
      en:
        path: "en/tools/health-check"
      cy:
        path: "cy/tools/gwiriad-iechyd"
      width: "100%"
      height: "800px"
      title: "Money health check"

    savings_calculator:
      en:
        path: "en/tools/savings-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-cynilo"
      width: "100%"
      height: "1000px"
      title: "Savings calculator"

    redundancy_action_plans:
      en:
        path: "en/tools/redundancy-pay-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-tal-diswyddo"
      width: "100%"
      title: "Redundancy action plan"
      omit_logo: true

    credit_card_calculator:
      en:
        path: "en/tools/credit-card-calculator/credit-card"
      cy:
        path: "cy/tools/cyfrifiannell-cerdyn-credyd/credit-card"
      title: "Credit card calculator"

    loan_calculator:
      en:
        path: "en/tools/loan-calculator/loan"
      cy:
        path: "cy/tools/cyfrifiannell-benthyciadau/loan"
      title: "Loan calculator"
      width: "100%"
      height: "1200px"

    loan_calculator_beta:
      en:
        path: "en/tools/loan-calculator/loan"
      cy:
        path: "cy/tools/cyfrifiannell-benthyciadau/loan"
      title: "Loan calculator"

    debt_and_mental_health:
      en:
        path: "en/debt-and-mental-health/preview"
      title: "Debt and mental health"
      width: "100%"
      height: "800px"

    debt_advice_locator:
      en:
        path: "en/tools/debt-advice-locator"
      cy:
        path: "cy/tools/canfyddwr-cyngor-ar-ddyledion"
      title: "Debt advice locator"
      omit_logo: true

    debt_advice_locator_f2f:
      en:
        path: "en/tools/debt-advice-locator/f2f"
      cy:
        path: "cy/tools/canfyddwr-cyngor-ar-ddyledion/f2f"
      title: "Debt advice locator - face to face"
      width: "100%"
      omit_logo: true

    car_cost_tool:
      en:
        path: "en/tools/car-costs-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-costau-car"
      title: "Car costs calculator"

    quick_cash_finder:
      en:
        path: "en/tools/quick-cash-finder"
      cy:
        path: "cy/tools/canfod-arian-parod-yn-gyflym"
      title: "Quick cash finder"

    universal_credit:
      en:
        path: 'en/tools/money-manager'
      cy:
        path: 'cy/tools/rheolwr-arian'
      width: "100%"
      title: 'Money Manager'

    wpcc:
      en:
        path: 'en/tools/workplace-pension-contribution-calculator'
      cy:
        path: 'cy/tools/cyfrifiannell-cyfraniadau-pensiwn-gweithle'
      width: "100%"
      height: "1550px"
      title: 'Workplace Pension Contribution Calculator'

    money_navigator_tool:
      en:
        path: 'en/tools/money-navigator-tool'
      cy:
        path: 'cy/tools/teclyn-llywio-ariannol'
      width: "100%"
      title: 'Money Navigator'

    default_dimensions:
      width: "680px"
      height: "1000px"

  getLocale: (node)->
    if node.lang == 'cy'
    then locale = 'cy'
    else locale = 'en'

  iframeUrl: (node)->
    locale = masConfig.getLocale(node)
    toolpath = masConfig.toolConfig[node.id][locale].path
    "#{masConfig.toolsConfig['syndication_url']}/#{toolpath}"

  iframeSrc: (node)->
    "src='#{masConfig.iframeUrl(node)}'"

  iframeScrolling: "no"
  iframeBorder: "0"
  iframeClass: "mas-widget-iframe"

syndication = new window.PartnerMAS.ToolSyndication

renderOnLoad = ->
  (if document.readyState isnt "complete" then setTimeout(renderOnLoad, 11) else syndication.renderWidgets())

renderOnLoad()

