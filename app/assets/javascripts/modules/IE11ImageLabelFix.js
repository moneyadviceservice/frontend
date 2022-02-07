define(["module"], function (module) {
  "use strict";

  function getInternetExplorerVersion() {
    var rv = -1;
    if (navigator.appName == "Microsoft Internet Explorer") {
      var ua = navigator.userAgent;
      var re = new RegExp("MSIE ([0-9]{1,}[\\.0-9]{0,})");
      if (re.exec(ua) != null) rv = parseFloat(RegExp.$1);
    } else if (navigator.appName == "Netscape") {
      var ua = navigator.userAgent;
      var re = new RegExp("Trident/.*rv:([0-9]{1,}[\\.0-9]{0,})");
      if (re.exec(ua) != null) rv = parseFloat(RegExp.$1);
    }
    return rv;
  }

  window.onload = function () {
    if (getInternetExplorerVersion()) {
      var labels = document.getElementsByTagName("label");
      for (var i = 0; i < labels.length; i++) {
        var label = labels[i];
        var labelImages = label.getElementsByTagName("img");

        for (var a = 0; a < labelImages.length; a++) {
          var labelImage = labelImages[a];
          labelImage.forid = label.htmlFor;
          labelImage.onclick = function () {
            var e = document.getElementById(this.forid);
            switch (e.type) {
              case "radio":
                e.checked |= 1;
                break;
              case "checkbox":
                e.checked = !e.checked;
                break;
              case "text":
              case "password":
              case "textarea":
                e.focus();
                break;
            }
          };
        }
      }
    }
  };
});
