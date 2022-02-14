define(["module"], function (module) {
  "use strict";

  function getInternetExplorerVersion() {
    // https://stackoverflow.com/questions/21825157/internet-explorer-11-detection
    var isIE11 = !!window.MSInputMethodContext && !!document.documentMode;
    return isIE11;
  }

  function ready(fn) {
    if (document.readyState != "loading") {
      fn();
    } else {
      document.addEventListener("DOMContentLoaded", fn);
    }
  }

  function bindImageClickEvents() {
    document.addEventListener(
      "click",
      function (e) {
        if (e.target.tagName === "IMG") {
          var parent = e.target.parentNode;
          while (true) {
            if (!parent) {
              return;
            } else if (parent.tagName === "LABEL") {
              return parent.click();
            }
            parent = parent.parentNode;
          }
        }
      },
      false
    );
  }

  if (getInternetExplorerVersion()) {
    ready(function () {
      bindImageClickEvents();
    });
  }
});
