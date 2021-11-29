document.addEventListener("DOMContentLoaded", function(event) {
  const sendScrollToTopMessage = () => {
    if (window.parent && window.parent.postMessage) {
      // this only works because the parent in AEM receives the message
      // and has code to act on it
      window.parent.postMessage({scrollToTop: true}, '*');
    }
  }

  sendScrollToTopMessage()

  document.getElementsByClassName("back_to_top__link").forEach((element) => {
    element.addEventListener("click", () => { sendScrollToTopMessage() })
  })
});
