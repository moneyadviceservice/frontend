#= require ./widget

class window.PartnerMAS.ToolSyndication
  findWidgetTargets: ->
    if document.all
      allElements = document.all
    else
      allElements = document.getElementsByTagName "*"

    el for el in allElements when el.className == masConfig.targetSelector

  renderWidgets: ->
    for node in this.findWidgetTargets()
      do(node) ->
        widget = new window.PartnerMAS.Widget(node)
        widget.render()
