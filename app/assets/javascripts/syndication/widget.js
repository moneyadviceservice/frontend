// Generated by CoffeeScript 1.12.7
(function() {
  var slice = [].slice;

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
      this.setPartnerToolsURL();
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

    Widget.prototype.setPartnerToolsURL = function() {
      var domains, hostname;
      domains = {
        'www.preview.dev.mas.local': 'https://preview-partner-tools.dev.mas.local/',
        'www.qa.dev.mas.local': 'https://qa-partner-tools.dev.mas.local/',
        'www.uat.dev.mas.local': 'https://uat-partner-tools.dev.mas.local/',
        'www.cultivate.dev.mas.local': 'https://cultivate-partner-tools.dev.mas.local/',
        'www.staging.dev.mas.local': 'https://staging-partner-tools.dev.mas.local/',
        'www.uat.moneyadviceservice.org.uk': 'https://uat-partner-tools.moneyadviceservice.org.uk/'
      };
      hostname = document.getElementsByClassName(masConfig.targetSelector)[0].hostname;
      masConfig.toolsConfig = {
        syndication_url: 'https://6a583ddb80a3.ngrok.io',
        syndication: {
          ga_iframe_url: 'https://partner-tools.moneyadviceservice.org.uk/partner_ga_iframe.html'
        }
      };
      if (domains[hostname]) {
        return masConfig.toolsConfig['syndication_url'] = domains[hostname];
      }
    };

    Widget.prototype.createContainer = function() {
      var contents;
      contents = 1 <= arguments.length ? slice.call(arguments, 0) : [];
      return "<div class='" + masConfig.containerClass + "' id='" + this.targetNode.id + "-container' style='" + masConfig.containerStyles + "'>\n  " + (contents.join('\n')) + "\n</div>";
    };

    Widget.prototype.createLogo = function() {
      return "<a class='" + masConfig.linkClass + "' href='" + masConfig.linkHref + "' target='" + masConfig.linkTarget + "'>\n  <img src='" + masConfig.logoSrc + "' alt='" + masConfig.logoAltText + "' style='" + masConfig.logoStyles + "'/>\n</a>";
    };

    Widget.prototype.createIFrame = function() {
      return "<iframe class='" + masConfig.iframeClass + "' id='" + this.targetNode.id + "-iframe' " + (masConfig.iframeSrc(this.targetNode)) + "\n        scrolling='" + masConfig.iframeScrolling + "' frameborder='" + masConfig.iframeBorder + "'\n        width='" + (this.dataAttr('width')) + "' height='" + (this.dataAttr('height')) + "' title='" + (this.dataAttr('title')) + "'>\n</iframe>";
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

}).call(this);
