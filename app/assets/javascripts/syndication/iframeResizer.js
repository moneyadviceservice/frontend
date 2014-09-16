window.iframeResizer = function(msgPrefix, targetOrigin, minFrameHeight) {
  var timer, frameDefaultOverflow;

  minFrameHeight = minFrameHeight || 250;
  targetOrigin = targetOrigin || '*';

  return {
    start: function() {
      if (!window.postMessage) {
        return;
      }

      var currentHeight = 0,
          bodyNode = document.body,
          frameTopMargin,
          frameBtmMargin;

      frameDefaultOverflow = window.getComputedStyle(bodyNode).overflow;
      document.documentElement.style.overflow = 'hidden';
      frameTopMargin = parseInt(window.getComputedStyle(bodyNode).marginTop, 16);
      frameBtmMargin = parseInt(window.getComputedStyle(bodyNode).marginBottom, 16);

      timer = setInterval(function() {
        var documentHeight = Math.max(
                frameTopMargin + frameBtmMargin + bodyNode.clientHeight,
            minFrameHeight
        );
        if (documentHeight !== currentHeight) {
          window.parent.postMessage(msgPrefix + documentHeight, targetOrigin);
          currentHeight = documentHeight;
        }
      }, 200);
    },
    stop: function() {
      clearInterval(timer);
      document.documentElement.style.overflow = frameDefaultOverflow;
    }
  };
};
