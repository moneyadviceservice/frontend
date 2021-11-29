document.addEventListener("DOMContentLoaded", function(event) {
  function sendScrollToTopMessage () {
    if (window.parent && window.parent.postMessage) {
      // this only works because the parent in AEM receives the message
      // and has code to act on it
      window.parent.postMessage({scrollToTop: true}, '*');
    }
  }

  sendScrollToTopMessage()

  var elements = document.getElementsByClassName("back_to_top__link")
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i]
    element.addEventListener("click", function() { sendScrollToTopMessage() })
  }
});
