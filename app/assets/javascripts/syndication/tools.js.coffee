#= require ./tool_syndication
#= require ./resizer

@masConfig =
  targetSelector: "mas-widget"
  containerClass: "mas-widget-container"
  containerStyles: "width: 100%; margin: 0 auto;"
  linkClass: "mas-widget-logo-link"
  linkHref: "https://www.moneyadviceservice.org.uk/"
  linkTarget: "_blank"
  logoSrc: "https://www.moneyadviceservice.org.uk/assets/logo_en.png"
  logoStyles: "display: block; margin-bottom: 8px;"
  logoAltText: "Money Advice Service"

  toolConfig:
    baby_timeline:
      en:
        path: "en/tools/baby-money-timeline"
      cy:
        path: "cy/tools/llinell-amser-arian-babi"
      width: "100%"
      height: "800px"
      include_ga: false
      title: "Baby money timeline"

    baby_timeline_mumsnet:
      en:
        path: "en/tools/baby-money-timeline?version=mumsnet"
      width: "100%"
      height: "800px"
      include_ga: false
      title: "Baby money timeline"

    debt_test:
      en:
        path: "en/tools/debt-test"
      cy:
        path: "cy/tools/prawf-dyledion"
      width: "100%"
      height: "1550px"
      include_ga: false
      title: "Debt test"

    help_to_buy_quiz:
      en:
        path: "en/quiz/help_to_buy"
      width: "600px"
      height: "2000px"
      include_ga: false
      title: "Help to buy quiz"

    quiz:
      en:
        path: "en/tools/quiz"
      cy:
        path: "cy/tools/quiz"
      title: "Quiz"

    christmas_planner:
      en:
        path: "en/cost_planner/plans/christmas-syndicated/start"
      cy:
        path: "en/cost_planner/plans/christmas-syndicated/start"
      height: "2400px"
      width: "100%"
      include_ga: false
      title: "Christmas planner"

    christmas_planner_no_start_page:
      en:
        path: "en/cost_planner/plans/christmas-syndicated"
      width: "100%"
      height: "2400px"
      include_ga: false
      title: "Christmas planner"

    budget_planner:
      en:
        path: "en/tools/budget-planner"
      cy:
        path: "cy/tools/cynllunydd-cyllideb"
      width: "100%"
      height: "2500px"
      include_ga: false
      title: "Budget planner"

    budget_planner_incognito:
      en:
        path: "en/tools/budget-planner/incognito"
      cy:
        path: "en/tools/cynllunydd-cyllideb/incognito"
      width: "100%"
      height: "2500px"
      include_ga: false
      title: "Budget planner"

    back_to_school:
      en:
        path: "en/cost_planner/plans/back-to-school/start"
      width: "100%"
      height: "2100px"
      include_ga: false
      title: "Back to school"

    divorce_and_separation:
      en:
        path: "divorce_separation_calculator/index.html"
      width: "748px"
      height: "1230"
      include_ga: true
      title: "Divorce and separation calculator"

    workplace_pensions:
      en:
        path: "workplace_pensions_calculator/index.html"
      cy:
        path: "workplace_pensions_calculator/index.html?lang=cy"
      width: "800px"
      height: "2200px"
      include_ga: false
      title: "Workplace pensions calculator"

    baby:
      en:
        path: "baby_cost_calculator_syndicated/index.html"
      cy:
        path: "baby_cost_calculator_syndicated/index.html?lang=cy"
      width: "620px"
      height: "1030px"
      include_ga: false
      title: "Baby cost calculator"

    universal_credit_timeline:
      en:
        path: "universal_credit_timeline/index.html"
      cy:
        path: "universal_credit_timeline/index_cy.html"
      width: "960px"
      height: "700px"
      include_ga: true
      title: "Universal credit timeline"

    auto_enrolment:
      en:
        path: "en/tools/workplace-pension-advice-tool"
      width: "960px"
      height: "700px"
      include_ga: false
      title: "Workplace pension advice tool"

    summer_planner:
      en:
        path: "summer_planner/index.html"
      cy:
        path: "summer_planner/index.html?lang=cy"
      height: "1340px"
      width: "720px"
      include_ga: false
      title: "Summer planner"

    how_much_to_save:
      en:
        path: "how_much_to_save_2013_04_08_en/index.htm"
      cy:
        path: "how_much_to_save_2013_04_08_cy/index.htm"
      height: "700px"
      width: "680px"
      include_ga: true
      title: "How much to save"

    mortgage_calculator_new:
      en:
        path: "en/tools/mortgage-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-morgais"
      width: "100%"
      include_ga: false
      title: "Mortgage calculator"

    mortgage_calculator:
      en:
        path: "en/tools/mortgage-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-morgais"
      width: "100%"
      include_ga: false
      title: "Mortgage calculator"

    stamp_duty:
      en:
        path: "en/tools/house-buying/stamp-duty-calculator"
      cy:
        path: "cy/tools/prynu-ty/cyfrifiannell-treth-stamp"
      title: "Stamp duty calculator"

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
      include_ga: false
      omit_logo: true
      title: "Payday loans"

    pensions_calculator:
      en:
        path: "en/tools/pension-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-pensiwn"
      width: "100%"
      height: "800px"
      include_ga: false
      title: "Pensions calculator"

    health_check:
      en:
        path: "en/tools/health-check"
      cy:
        path: "cy/tools/gwiriad-iechyd"
      width: "100%"
      height: "800px"
      include_ga: false
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

    default_dimensions:
      width: "680px"
      height: "1000px"

  getLocale: (node)->
    if node.lang == 'cy'
    then locale = 'cy'
    else locale = 'en'

  gaPath: (node)->
    locale = masConfig.getLocale(node)
    toolpath = masConfig.toolConfig[node.id][locale].ga_path

  iframeUrl: (node)->
    locale = masConfig.getLocale(node)
    toolpath = masConfig.toolConfig[node.id][locale].path

    if toolsConfig?
    then "#{toolsConfig['syndication_url']}/#{toolpath}"
    else "https://partner-tools.moneyadviceservice.org.uk/#{toolpath}"

  iframeSrc: (node)->
    "src='#{masConfig.iframeUrl(node)}'"

  gaIframeUrl: (node)->
    locale = masConfig.getLocale(node)
    toolId = node.id

    if toolsConfig?
    then toolURL = toolsConfig['syndication']['ga_iframe_url']
    else toolURL = "https://partner-tools.moneyadviceservice.org.uk/partner_ga_iframe.html"

    toolArgs = "?tool=#{toolId}&lang=#{locale}"

    "#{toolURL}#{toolArgs}"

  gaIframeSrc: (node)->
    "src='#{masConfig.gaIframeUrl(node)}'"

  gaIframeRequired: (node)->
    if (masConfig.toolConfig[node.id]['include_ga']?)
      return masConfig.toolConfig[node.id]['include_ga']
    false

  iframeScrolling: "no"
  iframeBorder: "0"
  iframeClass: "mas-widget-iframe"
  gaIframeClass: "mas-widget-ga-iframe"

syndication = new window.PartnerMAS.ToolSyndication

renderOnLoad = ->
  (if document.readyState isnt "complete" then setTimeout(renderOnLoad, 11) else syndication.renderWidgets())

renderOnLoad()

