window.handleMASResizeMessage = (event) ->
  try
    if typeof (event.data) is "string"
      parts = event.data.split("-")
      prefix = parts[0]
      height = parseInt(parts[1])
      if prefix is "MASRESIZE"
        iframe = document.querySelector(".mas-widget-iframe")
        iframe.style.height = height + "px"
    return
  catch error
    # Be silent

if window.addEventListener
  addEventListener "message", window.handleMASResizeMessage, false
else
  attachEvent "onmessage", window.handleMASResizeMessage

