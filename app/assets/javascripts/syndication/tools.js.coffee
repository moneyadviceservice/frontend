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
  logoStyles: "display: block; margin-bottom: 8px; width: 300px"
  logoAltText: "Money Advice Service"

  toolConfig:
    mortgage_calculator:
      en:
        path: "en/tools/mortgage-calculator"
      cy:
        path: "cy/tools/cyfrifiannell-morgais"
      width: "100%"
      include_ga: false
      title: "Mortgage calculator"

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
    "#{masConfig.toolsConfig['syndication_url']}/#{toolpath}"

  iframeSrc: (node)->
    "src='#{masConfig.iframeUrl(node)}'"

  gaIframeUrl: (node)->
    locale = masConfig.getLocale(node)
    toolId = node.id
    toolURL = masConfig.toolsConfig['syndication']['ga_iframe_url']
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

