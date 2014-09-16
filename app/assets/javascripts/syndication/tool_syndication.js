var __slice = [].slice;

if (window.PartnerMAS == null) {
  window.PartnerMAS = {};
}

window.PartnerMAS.Widget = (function() {
  function Widget(targetNode) {
    this.targetNode = targetNode;
    this.id = this.targetNode.id;
  }

  Widget.prototype.render = function() {
    var renderParts;
    renderParts = [];
    if (!this.dataAttr("omit_logo")) {
      renderParts.push(this.createLogo());
    }
    renderParts.push(this.createIFrame());
    if (masConfig.gaIframeRequired(this.targetNode)) {
      renderParts.push(this.createGAIFrame());
    }
    this.addToDocument(this.createContainer.apply(this, renderParts));
    return this.removeTargetNode();
  };

  Widget.prototype.createContainer = function() {
    var contents;
    contents = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    return "<div class='" + masConfig.containerClass + "' id='" + this.targetNode.id + "-container' style='" + masConfig.containerStyles + "'>\n  " + (contents.join('\n')) + "\n</div>";
  };

  Widget.prototype.createLogo = function() {
    return "<a class='" + masConfig.linkClass + "' href='" + masConfig.linkHref + "' target='" + masConfig.linkTarget + "'>\n  <img src='" + masConfig.logoSrc + "' alt='" + masConfig.logoAltText + "' style='" + masConfig.logoStyles + "'/>\n</a>";
  };

  Widget.prototype.createIFrame = function() {
    return "<iframe class='" + masConfig.iframeClass + "' id='" + this.targetNode.id + "-iframe' " + (masConfig.iframeSrc(this.targetNode)) + "\n        scrolling='" + masConfig.iframeScrolling + "' frameborder='" + masConfig.iframeBorder + "'\n        width='" + (this.dataAttr('width')) + "' height='" + (this.dataAttr('height')) + "'>\n</iframe>";
  };

  Widget.prototype.createGAIFrame = function() {
    return "<iframe class='" + masConfig.gaIframeClass + "' id='" + this.targetNode.id + "-ga-iframe' " + (masConfig.gaIframeSrc(this.targetNode)) + "\n        scrolling='no' frameborder='0'\n        width='0px' height='0px'>\n</iframe>";
  };

  Widget.prototype.removeTargetNode = function() {
    return this.targetNode.parentNode.removeChild(this.targetNode);
  };

  Widget.prototype.addToDocument = function(html) {
    var child, fragment, tmp;
    fragment = document.createDocumentFragment();
    tmp = document.createElement('body');
    tmp.innerHTML = html;
    while (child = tmp.firstChild) {
      fragment.appendChild(child);
    }
    this.targetNode.parentNode.insertBefore(fragment, this.targetNode);
    return fragment = tmp = null;
  };

  Widget.prototype.dataAttr = function(attribute) {
    var config, targetNodeAttr;
    config = masConfig.toolConfig[this.id];
    targetNodeAttr = this.targetNode.getAttribute("data-" + attribute);
    if (targetNodeAttr != null) {
      return targetNodeAttr;
    }
    if (config != null) {
      return config[attribute];
    }
    return masConfig.toolConfig["default_dimensions"][attribute];
  };

  return Widget;

})();


window.PartnerMAS.ToolSyndication = (function() {
  function ToolSyndication() {}

  ToolSyndication.prototype.findWidgetTargets = function() {
    var allElements, el, _i, _len, _results;
    if (document.all) {
      allElements = document.all;
    } else {
      allElements = document.getElementsByTagName("*");
    }
    _results = [];
    for (_i = 0, _len = allElements.length; _i < _len; _i++) {
      el = allElements[_i];
      if (el.className === masConfig.targetSelector) {
        _results.push(el);
      }
    }
    return _results;
  };

  ToolSyndication.prototype.renderWidgets = function() {
    var node, _i, _len, _ref, _results;
    _ref = this.findWidgetTargets();
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      node = _ref[_i];
      _results.push((function(node) {
        var widget;
        widget = new window.PartnerMAS.Widget(node);
        return widget.render();
      })(node));
    }
    return _results;
  };

  return ToolSyndication;

})();
