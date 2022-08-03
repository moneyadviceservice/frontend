window.PartnerMAS ?= {}

class window.PartnerMAS.Widget
  constructor: (@targetNode) ->
    @id = @targetNode.id

  render: ->
    this.setPartnerToolsURL()
    renderParts = []
    renderParts.push(this.createLogo(masConfig.getLocale(@targetNode))) unless this.dataAttr("omit_logo")
    renderParts.push(this.createIFrame())
    renderParts.push(this.createGAIFrame()) if masConfig.gaIframeRequired(@targetNode)
    this.addToDocument this.createContainer(renderParts...)
    this.removeTargetNode()

  setPartnerToolsURL: ->
    domains = {
      'www.preview.dev.mas.local': 'https://preview-partner-tools.dev.mas.local/',
      'www.qa.dev.mas.local': 'https://qa-partner-tools.dev.mas.local/',
      'www.uat.dev.mas.local': 'https://uat-partner-tools.dev.mas.local/',
      'www.cultivate.dev.mas.local': 'https://cultivate-partner-tools.dev.mas.local/',
      'www.staging.dev.mas.local': 'https://staging-partner-tools.dev.mas.local/',
      'www.uat.moneyadviceservice.org.uk': 'https://uat-partner-tools.moneyadviceservice.org.uk/'
    }

    hostname = document.getElementsByClassName(masConfig.targetSelector)[0].hostname;

    masConfig.toolsConfig = {
      syndication_url: 'https://partner-tools.moneyadviceservice.org.uk',
      syndication: {
        ga_iframe_url: 'https://partner-tools.moneyadviceservice.org.uk/partner_ga_iframe.html'
      }
    }
    masConfig.toolsConfig['syndication_url'] = domains[hostname] if domains[hostname]

  createContainer: (contents...) ->
    """
        <div class='#{masConfig.containerClass}' id='#{@targetNode.id}-container' style='#{masConfig.containerStyles}'>
          #{contents.join('\n')}
        </div>
        """

  createLogo: (locale)->
    """
        <a class='#{masConfig[locale].linkClass}' href='#{masConfig[locale].linkHref}' target='#{masConfig[locale].linkTarget}'>
          <img src='#{masConfig[locale].logoSrc}' alt='#{masConfig[locale].logoAltText}' style='#{masConfig[locale].logoStyles}'/>
        </a>
        """

  createIFrame: ->
    """
        <iframe class='#{masConfig.iframeClass}' id='#{@targetNode.id}-iframe' #{masConfig.iframeSrc(@targetNode)}
                scrolling='#{masConfig.iframeScrolling}' frameborder='#{masConfig.iframeBorder}'
                width='#{this.dataAttr('width')}' height='#{this.dataAttr('height')}' title='#{this.dataAttr('title')}'>
        </iframe>
        """

  createGAIFrame: ->
    """
        <iframe class='#{masConfig.gaIframeClass}' id='#{@targetNode.id}-ga-iframe' #{masConfig.gaIframeSrc(@targetNode)}
                scrolling='no' frameborder='0'
                width='0px' height='0px'>
        </iframe>
        """

  removeTargetNode: ->
    @targetNode.parentNode.removeChild(@targetNode)

  addToDocument: (html) ->
    fragment = document.createDocumentFragment()
    tmp = document.createElement('body')
    tmp.innerHTML = html

    fragment.appendChild child while child = tmp.firstChild
    @targetNode.parentNode.insertBefore(fragment, @targetNode)
    fragment = tmp = null

  dataAttr: (attribute) ->
    config = masConfig.toolConfig[@id]
    targetNodeAttr = @targetNode.getAttribute("data-#{attribute}")

    return targetNodeAttr if targetNodeAttr?
    return config[attribute] if config?
    masConfig.toolConfig["default_dimensions"][attribute]
