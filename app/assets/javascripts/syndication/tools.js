//= require ./tool_syndication
//= require ./resizer

var renderOnLoad, syndication;

this.masConfig = {
  targetSelector: "mas-widget",
  containerClass: "mas-widget-container",
  containerStyles: "width: 100%; margin: 0 auto;",
  linkClass: "mas-widget-logo-link",
  linkHref: "https://www.moneyadviceservice.org.uk/",
  linkTarget: "_blank",
  logoSrc: "https://www.moneyadviceservice.org.uk/assets/logo_en.png",
  logoStyles: "display: block; margin-bottom: 8px;",
  logoAltText: "Money Advice Service",
  toolConfig: {
    pensions_calculator: {
      en: {
        path: "en/tools/pension-calculator"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-pensiwn"
      },
      width: "100%",
      height: "800px",
      include_ga: false
    },
    baby_timeline: {
      en: {
        path: "en/tools/baby-money-timeline"
      },
      cy: {
        path: "cy/tools/llinell-amser-arian-babi"
      },
      width: "100%",
      height: "800px",
      include_ga: false
    },
    baby_timeline_mumsnet: {
      en: {
        path: "en/tools/baby-money-timeline?version=mumsnet"
      },
      width: "100%",
      height: "800px",
      include_ga: false
    },
    debt_test: {
      en: {
        path: "en/tools/debt-test"
      },
      cy: {
        path: "cy/tools/prawf-dyledion"
      },
      width: "100%",
      height: "900px",
      include_ga: false
    },
    help_to_buy_quiz: {
      en: {
        path: "en/quiz/help_to_buy"
      },
      width: "600px",
      height: "2000px",
      include_ga: false
    },
    christmas_planner: {
      en: {
        path: "en/cost_planner/plans/christmas-syndicated/start"
      },
      width: "100%",
      height: "2400px",
      include_ga: false
    },
    christmas_planner_no_start_page: {
      en: {
        path: "en/cost_planner/plans/christmas-syndicated"
      },
      width: "100%",
      height: "2400px",
      include_ga: false
    },
    budget_planner: {
      en: {
        path: "en/tools/budget-planner"
      },
      cy: {
        path: "en/tools/cynllunydd-cyllideb"
      },
      width: "100%",
      height: "2500px",
      include_ga: false
    },
    budget_planner_incognito: {
      en: {
        path: "en/tools/budget-planner/incognito"
      },
      cy: {
        path: "en/tools/cynllunydd-cyllideb/incognito"
      },
      width: "100%",
      height: "2500px",
      include_ga: false
    },
    back_to_school: {
      en: {
        path: "en/cost_planner/plans/back-to-school/start"
      },
      width: "100%",
      height: "2100px",
      include_ga: false
    },
    divorce_and_separation: {
      en: {
        path: "divorce_separation_calculator/index.html"
      },
      width: "748px",
      height: "1230",
      include_ga: true
    },
    workplace_pensions: {
      en: {
        path: "workplace_pensions_calculator/index.html"
      },
      cy: {
        path: "workplace_pensions_calculator/index.html?lang=cy"
      },
      width: "800px",
      height: "2200px",
      include_ga: false
    },
    baby: {
      en: {
        path: "baby_cost_calculator_syndicated/index.html"
      },
      cy: {
        path: "baby_cost_calculator_syndicated/index.html?lang=cy"
      },
      width: "620px",
      height: "1030px",
      include_ga: false
    },
    universal_credit_timeline: {
      en: {
        path: "universal_credit_timeline/index.html"
      },
      cy: {
        path: "universal_credit_timeline/index_cy.html"
      },
      width: "960px",
      height: "700px",
      include_ga: true
    },
    auto_enrolment: {
      en: {
        path: "en/tools/workplace-pension-advice-tool"
      },
      width: "960px",
      height: "700px",
      include_ga: false
    },
    summer_planner: {
      en: {
        path: "summer_planner/index.html"
      },
      cy: {
        path: "summer_planner/index.html?lang=cy"
      },
      height: "1340px",
      width: "720px",
      include_ga: false
    },
    how_much_to_save: {
      en: {
        path: "how_much_to_save_2013_04_08_en/index.htm"
      },
      cy: {
        path: "how_much_to_save_2013_04_08_cy/index.htm"
      },
      height: "700px",
      width: "680px",
      include_ga: true
    },
    christmas_planner: {
      en: {
        path: "en/cost_planner/plans/christmas-syndicated/start"
      },
      cy: {
        path: "en/cost_planner/plans/christmas-syndicated/start"
      },
      height: "2400px",
      width: "100%",
      include_ga: false
    },
    mortgage_calculator_new: {
      en: {
        path: "en/tools/mortgage-calculator"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-morgais"
      },
      width: "100%",
      include_ga: false
    },
    mortgage_calculator: {
      en: {
        path: "en/tools/mortgage-calculator"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-morgais"
      },
      width: "100%",
      include_ga: false
    },
    stamp_duty: {
      en: {
        path: "en/tools/house-buying/stamp-duty-calculator"
      },
      cy: {
        path: "cy/tools/prynu-ty/cyfrifiannell-treth-stamp"
      }
    },
    mortgage_affordability_calculator: {
      en: {
        path: "en/tools/house-buying/mortgage-affordability-calculator"
      },
      cy: {
        path: "cy/tools/prynu-ty/cyfrifiannell-fforddiadwyedd-morgais"
      }
    },
    payday_loans_intervention: {
      en: {
        path: "en/payday-loans"
      },
      cy: {
        path: "cy/benthyciadau-diwrnod-cyflog"
      },
      height: "1500px",
      width: "100%",
      include_ga: false,
      omit_logo: true
    },
    savings_calculator: {
      en: {
        path: "en/tools/savings-calculator"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-cynilo"
      },
      width: "100%",
      height: "1000px"
    },
    redundancy_action_plans: {
      en: {
        path: "en/action-plans/redundancy"
      },
      cy: {
        path: "cy/action-plans/dileu-swydd"
      },
      width: "100%"
    },
    credit_card_calculator: {
      en: {
        path: "en/tools/credit-card-calculator/credit-card"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-cerdyn-credyd/credit-card"
      }
    },
    loan_calculator: {
      en: {
        path: "en/tools/loan-calculator/loan"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-benthyciadau/loan"
      }
    },
    loan_calculator_beta: {
      en: {
        path: "en/tools/loan-calculator/loan"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-benthyciadau/loan"
      }
    },
    debt_advice_locator: {
      en: {
        path: "en/tools/debt-advice-locator"
      },
      cy: {
        path: "cy/tools/canfyddwr-cyngor-ar-ddyledion"
      }
    },
    car_cost_tool: {
      en: {
        path: "en/tools/car-costs-calculator"
      },
      cy: {
        path: "cy/tools/cyfrifiannell-costau-car"
      }
    },
    default_dimensions: {
      width: "680px",
      height: "1000px"
    }
  },
  getLocale: function(node) {
    var locale;
    if (node.lang === 'cy') {
      return locale = 'cy';
    } else {
      return locale = 'en';
    }
  },
  gaPath: function(node) {
    var locale, toolpath;
    locale = masConfig.getLocale(node);
    return toolpath = masConfig.toolConfig[node.id][locale].ga_path;
  },
  iframeUrl: function(node) {
    var locale, toolpath;
    locale = masConfig.getLocale(node);
    toolpath = masConfig.toolConfig[node.id][locale].path;
    if (typeof toolsConfig !== "undefined" && toolsConfig !== null) {
      return "" + toolsConfig['syndication_url'] + "/" + toolpath;
    } else {
      return "https://partner-tools.moneyadviceservice.org.uk/" + toolpath;
    }
  },
  iframeSrc: function(node) {
    return "src='" + (masConfig.iframeUrl(node)) + "'";
  },
  gaIframeUrl: function(node) {
    var locale, toolArgs, toolId, toolURL;
    locale = masConfig.getLocale(node);
    toolId = node.id;
    if (typeof toolsConfig !== "undefined" && toolsConfig !== null) {
      toolURL = toolsConfig['syndication']['ga_iframe_url'];
    } else {
      toolURL = "https://partner-tools.moneyadviceservice.org.uk/partner_ga_iframe.html";
    }
    toolArgs = "?tool=" + toolId + "&lang=" + locale;
    return "" + toolURL + toolArgs;
  },
  gaIframeSrc: function(node) {
    return "src='" + (masConfig.gaIframeUrl(node)) + "'";
  },
  gaIframeRequired: function(node) {
    if ((masConfig.toolConfig[node.id]['include_ga'] != null)) {
      return masConfig.toolConfig[node.id]['include_ga'];
    }
    return false;
  },
  iframeScrolling: "no",
  iframeBorder: "0",
  iframeClass: "mas-widget-iframe",
  gaIframeClass: "mas-widget-ga-iframe"
};

syndication = new window.PartnerMAS.ToolSyndication;

renderOnLoad = function() {
  if (document.readyState !== "complete") {
    return setTimeout(renderOnLoad, 11);
  } else {
    return syndication.renderWidgets();
  }
};

renderOnLoad();
