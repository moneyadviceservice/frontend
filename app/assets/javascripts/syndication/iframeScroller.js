document.addEventListener("DOMContentLoaded", function(event) {
  // this only works because the parent in AEM receives the message
  // and has code to act on it
  if (window.parent && window.parent.postMessage) {
    window.parent.postMessage({scrollToTop: true}, '*');
  }
});
