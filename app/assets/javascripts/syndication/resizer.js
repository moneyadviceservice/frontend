window.handleMASResizeMessage = function(event) {
  var height, iframe, parts, prefix;
  try {
    if (typeof event.data === 'string') {
      parts = event.data.split('-');
      prefix = parts[0];
      height = parseInt(parts[1]);
      if (prefix === 'MASRESIZE') {
        iframe = document.querySelector('.mas-widget-iframe');
        iframe.style.height = height + 'px';
      }
    }
  } catch (err) { }
};

if (window.addEventListener) {
  addEventListener('message', window.handleMASResizeMessage, false);
} else {
  attachEvent('onmessage', window.handleMASResizeMessage);
}
