window.PartnerMAS ?= {}

class window.PartnerMAS.Widget
  constructor: (@targetNode) ->
    @id = @targetNode.id

  render: ->
    renderParts = []
    renderParts.push(this.createLogo()) unless this.dataAttr("omit_logo")
    renderParts.push(this.createIFrame())
    renderParts.push(this.createGAIFrame()) if masConfig.gaIframeRequired(@targetNode)
    this.addToDocument this.createContainer(renderParts...)
    this.removeTargetNode()

  createContainer: (contents...) ->
    """
        <div class='#{masConfig.containerClass}' id='#{@targetNode.id}-container' style='#{masConfig.containerStyles}'>
          #{contents.join('\n')}
        </div>
        """

  createLogo: ->
    """
        <a class='#{masConfig.linkClass}' href='#{masConfig.linkHref}' target='#{masConfig.linkTarget}'>
          <img src='#{masConfig.logoSrc}' alt='#{masConfig.logoAltText}' style='#{masConfig.logoStyles}'/>
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
