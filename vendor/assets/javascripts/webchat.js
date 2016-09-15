/*
 * Instead of using 2 javascript files hosted on webchat.moneyadviceservice.org.uk we are using a single local file
 * Originally the first file (invite.js) uses a document.write for the second file (include.js)
 * I have commented out the document.write - see the numbered comments below
 * [1] start copy of https://webchat.moneyadviceservice.org.uk/invite.js?domain=<%= ENV['WEBCHAT_DOMAIN'] %>
 * [2] set sWOProtocol to 'https:'
 * [3] comment out document.write of include.js
 * [4] start copy of https://webchat.moneyadviceservice.org.uk/include.js?domain=<%= ENV['WEBCHAT_DOMAIN'] %>
 * */


/*
* [1] start copy of https://webchat.moneyadviceservice.org.uk/invite.js?domain=<%= ENV['WEBCHAT_DOMAIN'] %>
* */

var sWOGateway = "webchat.moneyadviceservice.org.uk";
var sWOGatewaySSL = "webchat.moneyadviceservice.org.uk";
var sWODomain = "";
var sWOChatstart = "https://webchat.moneyadviceservice.org.uk/newchat/chat.aspx";
var sWODepartment = "";
var sWOSkillNames = "";
var sWOLanguage = "";
var sWOBackgroundURL = "";
var sWOResponse = "Y";
var sWOInvite = "Y";
var sWOPreselect = "";
var sWOUser = "";
var sWOPage = "";
var sWOCost = 0;
var sWORevenue = 0;
var sWOName = "";
var sWOCompany = "";
var sWOEmail = "";
var sWOTelephone = "";
var sWOProtocol = "https:"; // [2] set sWOProtocol to https:
var sWOImage = document.createElement('img');
var sWOChatElement;
var sWOSession;
var sWOUrl;
sWOImage.border = 0;
(function () {
  if (sWOUser == "") {
    var dt = new Date();
    var sWOCookie = document.cookie.toString();
    if (sWOCookie.indexOf("whoson") == -1) {
      sWOSession = parseInt(Math.random() * 1000) + "-" + dt.getTime();
      document.cookie = "whoson=" + sWOSession + ";expires=Thu, 31-Dec-2020 00:00:00 GMT; path=/";
    }
    sWOCookie = document.cookie.toString();
    if (sWOCookie.indexOf('whoson') == -1) {
      sWOSession = "";
    } else {
      var s = sWOCookie.indexOf("whoson=") + "whoson=".length;
      var e = sWOCookie.indexOf(";", s);
      if (e == -1)e = sWOCookie.length;
      sWOSession = sWOCookie.substring(s, e);
    }
  }
  if (sWOProtocol == "https:")sWOGateway = sWOGatewaySSL;
  if (sWOUser != "")sWOSession = sWOUser;
  if (sWOProtocol == "file:")sWOProtocol = "http:";
})();
function sWOStartChat() {
  window.open(sWOChatElement.href, "Chat", "width=484,height=361,scrollbars=yes,resizable=yes");
  return false;
}
function sWOImageLoaded() {
  if (sWOImage.width == 1) {
    return;
  }
  sWOChatElement.href = sWOChatstart;
  sWOChatElement.target = "_blank";
  sWOChatElement.appendChild(sWOImage);
  sWOChatElement.onclick = sWOStartChat;
}
function sWOTrackPage() {
  if (sWOPage == "")sWOPage = escape(window.location);
  sWOUrl = sWOProtocol + "//" + sWOGateway + "/stat.gif?u=" + sWOSession + "&d=" + sWODomain;
  if (sWODepartment.length > 0)sWOUrl += "&t=" + escape(sWODepartment);
  sWOUrl += "&p='" + sWOPage + "'&r='" + escape(document.referrer) + "'";
  if (sWOCost != 0)sWOUrl += "&c=" + sWOCost;
  if (sWORevenue != 0)sWOUrl += "&v=" + sWORevenue;
  if (sWOName != "" || sWOCompany != "" || sWOEmail != "" || sWOTelephone != "")sWOUrl += "&n=" + sWOName + "|" + sWOCompany + "|" + sWOEmail + "|" + sWOTelephone;
  if (sWOSkillNames != "")sWOUrl += "&sn=" + escape(sWOSkillNames);
  if (sWOResponse == "") {
    if (document.layers)document.write("<layer name=\"WhosOn\" visibility=hide><img src=\"" + sWOUrl + "\" height=1 width=1><\/layer>");
    else document.write("<div id=\"WhosOn\" STYLE=\"position:absolute;visibility:hidden;\"><img src=\"" + sWOUrl + "\" height=1 width=1><\/div>");
  }
  else {
    sWOImage.onload = sWOImageLoaded;
    sWOChatElement = document.getElementById('whoson_chat_link');
    if (!sWOChatElement) {
      document.write("<a id='whoson_chat_link'></a>");
      sWOChatElement = document.getElementById('whoson_chat_link');
    }
    sWOUrl += "&response=g";
    sWOChatstart += "?domain=" + sWODomain;
    if (sWOLanguage.length > 0)sWOChatstart += "&lang=" + sWOLanguage;
    if (sWOBackgroundURL != "")sWOChatstart += "&bg=" + sWOBackgroundURL;
    if (sWODepartment.length > 0)sWOChatstart += "&dept=" + escape(sWODepartment);
    if (sWOPreselect.length > 0)sWOChatstart += "&select=" + sWOPreselect;
    if (sWOSkillNames != "")sWOChatstart += "&x-requestedskills=" + escape(sWOSkillNames);
    sWOChatstart += '&timestamp=' + (new Date()).getTime();
    sWOUrl += '&timestamp=' + (new Date()).getTime();
    if (sWOSession != '') {
      sWOChatstart += '&session=' + sWOSession;
    }
    sWOImage.src = sWOUrl;
  }

  /*
   * [3] comment out document.write of include.js
   * */
  //sWOUrl = sWOProtocol + "//" + sWOGateway + "/invite.js?domain=" + sWODomain;
  //if (sWOInvite == "Y") document.write("<sc" + "ript src='" + sWOUrl + "'><\/scr" + "ipt>");
}

/*
 * [4] start copy of https://webchat.moneyadviceservice.org.uk/include.js?domain=<%= ENV['WEBCHAT_DOMAIN'] %>
 * */

var iWOGateway = 'https://webchat.moneyadviceservice.org.uk';
if (typeof(sWOGateway) != 'undefined') {
  iWOGateway = sWOProtocol + "//" + sWOGateway;
}
var iWOSession = "";
if (typeof(sWOSession) != "undefined") {
  iWOSession = sWOSession
}
var woSWidth = 0, woSHeight = 0;
var startX = 0;
var startY = 200;
var closeX = 15;
var closeY = 15;
var invType = 0;
var paramData;
var closeToolTip;
var playSound = '';
var leaveOnScreen = 0;
var inviteFade = 0;
var fadeInterval = 0;
var locX = startX;
var locY = startY;
var imgW = 0;
var maxX = 0;
var maxY = 0;
var getC = 0;
var hldX = 0;
var incSpeed = 2;
var timeInterval = 39;
var incX = incSpeed;
var incY = 0;
var cStat = 1;
var mvTimer = 0;
var mvInterval = 0;
var imageOpacity = 1;
if (typeof(window.innerWidth) == 'number') {
  woSWidth = window.innerWidth;
  woSHeight = window.innerHeight
} else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
  woSWidth = document.documentElement.clientWidth;
  woSHeight = document.documentElement.clientHeight
} else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
  woSWidth = document.body.clientWidth;
  woSHeight = document.body.clientHeight
} else {
  woSWidth = 800;
  woSHeight = 600
}
imgPoll = new Image();
imgPoll.onload = chkImg;
if (iWOSession == "") {
  var sWOCookie = document.cookie.toString();
  if (sWOCookie.indexOf('whoson') == -1) {
    iWOSession = ""
  } else {
    var s = sWOCookie.indexOf("whoson=") + 7;
    var e = sWOCookie.indexOf(";", s);
    if (e == -1) {
      e = sWOCookie.length;
    }
    iWOSession = sWOCookie.substring(s, e)
  }
}
function woAfterLoad() {
  var tmpDiv = document.createElement('DIV');
  tmpDiv.setAttribute('name', 'woInvite');
  tmpDiv.setAttribute('id', 'woInvite');
  tmpDiv.setAttribute('align', 'right');
  tmpDiv.style.position = 'fixed';
  tmpDiv.style.top = startY;
  tmpDiv.style.left = startX;
  tmpDiv.style.zIndex = 999;
  document.body.appendChild(tmpDiv);
  function getImg() {
    var rTimer = 6000;
    var pUrl = iWOGateway + "/poll.gif?d=" + sWODomain + "&stamp=" + (new Date()).getTime();
    if (iWOSession != "") {
      pUrl += "&u=" + iWOSession
    }
    imgPoll.src = pUrl;
    getC++;
    if (getC > 184) {
      return
    }
    if (getC > 10) {
      rTimer = 10000
    }
    if (rTimer > 0) {
      setTimeout(getImg, rTimer)
    }
  }

  setTimeout(getImg, 1000)
}

function stopMove() {
  hldX = 2;
  if (leaveOnScreen === 0) {
    if (inviteFade == 1) {
      setInterval(fadeOutStep, 200)
    }
    setTimeout(stopInvite, 4000)
  }
}

function woMove() {
  if (hldX === 0) {
    locX = locX + incX;
    locY = locY + incY;
    if (locX <= 0) {
      if (invType === 0 || invType == 4) {
        stopMove()
      } else if (invType == 1) {
        incX = 0 - incX;
        locX = 0
      }
    } else if (locX >= maxX) {
      if (invType === 0 || invType == 4) {
        incX = 0 - incX;
        locX = maxX
      } else if (invType == 1) {
        stopMove()
      }
    }
    if (locY <= 0) {
      if (invType == 3 || invType == 4) {
        incY = 0 - incY;
        locY = 0
      } else if (invType == 2) {
        stopMove()
      }
    } else if (locY >= maxY) {
      if (invType == 2 || invType == 4) {
        incY = 0 - incY;
        locY = maxY
      } else if (invType == 3) {
        stopMove()
      }
    }
    woDIVs.left = (locX + 'px');
    woDIVs.top = (locY + 'px');
    mvInterval = setTimeout(woMove, timeInterval)
  } else {
    mvInterval = setTimeout(woMove, timeInterval * 10)
  }
}

function startMove() {
  mvInterval = setTimeout(woMove, timeInterval)
}

function setDefaults() {
  startX = 0;
  startY = 200;
  closeX = 15;
  closeY = 15;
  invType = 0;
  playSound = '';
  leaveOnScreen = 0;
  inviteFade = 0
}

function chkImg() {
  if (imgPoll != null) {
    nStat = imgPoll.width;
    if (cStat > 1 && nStat > 1) {
      stopInvite()
    }
    if (cStat != nStat) {
      cStat = nStat;
      if (cStat == 3)getParams();
      if (cStat == 2) {
        setDefaults();
        startInvite()
      }
    }
  }
}

imgPoll = new Image();
imgPoll.onload = chkImg;
function getIImgw() {
  imgW = woIMG.width;
  maxX = woSWidth - imgW;
  if (locX > maxX) {
    locX = maxX
  }
  maxY = woSHeight - woIMG.height;
  if (locY > maxY) {
    locY = maxY
  }
  woDIVs.left = locX + 'px';
  woDIVs.top = locY + 'px';
  if (playSound != '') {
    inviteSound()
  }
  if (inviteFade == 1) {
    fadeInvite()
  } else {
    woDIVs.opacity = 1;
    woDIVs.filter = "alpha(opacity=100)"
  }
}

function inviteSound() {
  var t = null;
  if (typeof navigator.mimeTypes['audio/wav'] == 'object') {
    t = document.createElement('embed');
    t.autostart = 1;
    t.playcount = 1;
    t.width = 0;
    t.height = 0;
    if (navigator.mimeTypes["application/x-mplayer2"].enabledPlugin != null) {
      t.type = "application/x-mplayer2"
    } else if (navigator.mimeTypes["audio/wav"].enabledPlugin != null) {
      t.type = "audio/wav"
    }
  } else {
    t = document.createElement('bgsound');
    t.loop = 0
  }
  if (t != null) {
    t.src = iWOGateway + "/" + playSound + "?domain=" + sWODomain;
    document.body.appendChild(t)
  }
}

function startInvite() {
  if (invType === 0) {
    incX = incSpeed;
    incY = 0
  } else if (invType == 1) {
    incX = 0 - incSpeed;
    incY = 0
  } else if (invType == 2) {
    incX = 0;
    incY = incSpeed
  } else if (invType == 3) {
    incX = 0;
    incY = 0 - incSpeed
  } else if (invType == 4) {
    incX = incSpeed;
    incY = incSpeed
  } else if (invType == 5) {
    incX = 0;
    incY = 0;
    hldX = 2
  }
  var ofsY;
  var iUrl = iWOGateway + "/invite.gif?d=" + sWODomain + "&stamp=" + (new Date()).getTime();
  if (iWOSession != "")iUrl += "&u=" + iWOSession;
  if (document.documentElement && document.documentElement.scrollTop) {
    ofsY = document.documentElement.scrollTop
  } else {
    ofsY = document.body.scrollTop
  }
  hldX = 0;
  locX = startX;
  locY = startY;
  woDIVs = document.getElementById('woInvite').style;
  woDIVh = document.getElementById('woInvite');
  imageOpacity = 0;
  woDIVs.opacity = 0;
  woDIVs.filter = "alpha(opacity=0)";
  woDIVh.innerHTML = '<a href="javascript:void(0);" onclick="return startChat(event);" onMouseOver="anPause()" onMouseOut="anResume()"><img border="0" src=' + iUrl + ' name="woIImg" /></a>';
  woDIVs.top = '0px';
  woDIVs.left = '0px';
  if (invType == 5) {
    setTimeout(stopInvite, 45000)
  } else {
    mvTimer = setTimeout(startMove, 3000)
  }
  woIMG = document.images.woIImg;
  woIMG.onload = getIImgw
}

function fadeInvite() {
  fadeInterval = setInterval(fadeInStep, 200)
}

function fadeInStep() {
  imageOpacity = imageOpacity + 0.05;
  woDIVs.opacity = imageOpacity;
  woDIVs.filter = "alpha(opacity=" + (imageOpacity * 100) + ")";
  if (imageOpacity >= 1) {
    clearTimeout(fadeInterval)
  }
}

function fadeOutStep() {
  imageOpacity = imageOpacity - 0.05;
  woDIVs.opacity = imageOpacity;
  woDIVs.filter = "alpha(opacity=" + (imageOpacity * 100) + ")";
  if (imageOpacity <= 0) {
    clearTimeout(fadeInterval)
  }
}

function stopInvite() {
  cStat = 1;
  woDIVh.innerHTML = "";
  if (mvTimer > 0) {
    clearTimeout(mvTimer)
  }
  if (mvInterval > 0) {
    clearTimeout(mvInterval);
    if (fadeInterval > 0) {
      clearInterval(fadeInterval)
    }
  }
}

function startChat(event) {
  if (event.clientX < locX + imgW - closeX || event.clientY > locY + closeY) {
    this.chatWindow = window.open("https://webchat.moneyadviceservice.org.uk/chat/chatstart.htm?domain=" + sWODomain, "Chat", "width=484,height=361");
    this.chatWindow.focus();
    this.chatWindow.opener = window
  }
  stopInvite()
}

function anPause() {
  if (hldX === 0) {
    hldX = 1
  }
}

function anResume() {
  if (hldX == 1) {
    hldX = 0
  }
}

function getParams() {
  var ifme = document.createElement("script");
  ifme.type = "text/javascript";
  ifme.language = "Javascript";
  ifme.src = iWOGateway + "/params.js?d=" + sWODomain + "&stamp=" + (new Date()).getTime() + ((iWOSession != "") ? "&u=" + iWOSession : "");
  document.body.appendChild(ifme)
}

function invJSLoaded() {
  parseParams();
  startInvite()
}

function parseParams() {
  invType = parseInt(parseParam('type', '0'));
  startX = parseInt(parseParam('startX', '0'));
  startY = parseInt(parseParam('startY', '30'));
  closeX = parseInt(parseParam('closeX', '5'));
  closeY = parseInt(parseParam('closeY', '5'));
  closeToolTip = parseParam('closetip', 'Close');
  playSound = parseParam('sound', '');
  leaveOnScreen = (parseParam('leave', 'N') == 'Y' ? 1 : 0);
  inviteFade = (parseParam('fade', 'N') == 'Y' ? 1 : 0)
}

function parseParam(paramName, defVal) {
  if (paramData.indexOf(paramName + "=") >= 0) {
    var pdata = paramData.split(paramName + "=");
    if (pdata.length == 1) {
      return def
    } else {
      return pdata[1].split(";")[0]
    }
  }
}

var woOldOnload = window.onload;
if (typeof woOldOnload == 'function') {
  if (!(String(woOldOnload).indexOf('woAfterLoad') > 0)) {
    var woRunOnload = woOldOnload;
    window.onload = function () {
      woRunOnload();
      woAfterLoad()
    }
  }
} else {
  window.onload = woAfterLoad
}
