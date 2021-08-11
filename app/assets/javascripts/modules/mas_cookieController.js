var defaults = {
  theme: "light",
  optionalCookies: [],
  necessaryCookies: [],
  text: {},
  branding: {},
};

var CookieController = function (opts) {
  this.config = Object.assign(defaults, opts);

  // TODO: replace locale and textStrings with the existing i18n module
  // This appears to be not functioning as it should right now
  // It should be fixed though it may be that it has never functioned as it should
  // Alternaively the locale object provided by this module could be used instead
  // this.locale = MAS.bootstrap.i18nLocale;
  this.locale = document.querySelector("html").lang;
  this.textStrings = {
    en: {
      optionalCookies: {
        analytics: {
          label: "Analytics Cookies",
          description:
            "These cookies allow us to collect anonymised data about how our website is being used, helping us to make improvements to the services we provide to you.",
        },
      },
      text: {
        title: "Cookies on Money Advice Service",
        intro:
          "<span>Cookies are files saved on your phone, tablet or computer when you visit a website.</span>" +
          "<span>We use cookies to store information about how you use the Money Advice Service website, such as the pages you visit.</span>" +
          '<span>For more information visit our <a href="/en/corporate/cookie_notice_en">Cookie Policy</a> and <a href="/en/corporate/privacy">Privacy Policy</a>.</span>',
        acceptSettings: "Accept all cookies",
        closeLabel: "Save preferences",
        on: "On",
        off: "Off",
        necessaryTitle: "Necessary Cookies",
        necessaryDescription:
          "Some cookies are essential for the site to function correctly, such as those remembering your progress through our tools, or using our webchat service.",
        notifyTitle: "Tell us whether you accept cookies",
        notifyDescription:
          '<span>We use <a href="/en/corporate/cookie_notice_en">cookies to collect information</a> about how you use this website.</span>' +
          "<span>We use this information to make the site work as well as possible and improve our services.</span>",
        accept: "Accept all cookies",
        settings: "Set preferences",
      },
      branding: {
        removeAbout: true,
        fontFamily:
          "'museo_sans', 'Helvetica Neue', Helvetica, Arial, sans-serif",
        fontSize: "1rem",
      },
    },
    cy: {
      optionalCookies: {
        analytics: {
          label: "Cwcis dadansoddi",
          description:
            "Mae&#8217;r cwcis hyn yn caniatáu i ni gasglu data dienw am sut mae ein gwefan yn cael ei defnyddio, gan ein helpu i wneud gwelliannau i&#8217;r gwasanaethau rydym yn eu darparu i chi.",
        },
      },
      text: {
        title: "Cwcis ar Gwasanaeth Cynghori Ariannol",
        intro:
          "<span>Mae cwcis yn ffeiliau a arbedir ar eich ffôn, llechen neu gyfrifiadur pan ymwelwch â gwefan.</span>" +
          "<span>Rydym yn defnyddio cwcis i storio gwybodaeth am sut rydych yn defnyddio Gwasanaeth Cynghori Ariannol, fel y tudalennau rydych chi&#8217;n ymweld â nhw.</span>" +
          '<span>I gael mwy o wybodaeth, ymwelwch â&#8217;n <a href="/cy/corporate/sut-yr-ydym-yn-defnyddio-cwcis">Polisi Cwcis</a> a&#8217;n <a href="/cy/corporate/polisipreifatrwydd">Polisi Preifatrwydd</a>.</span>',
        acceptSettings: "Derbyn pob cwci",
        closeLabel: "Arbed dewisiadau",
        on: "Ymlaen",
        off: "I ffwrdd",
        necessaryTitle: "Cwcis sydd eu hangen",
        necessaryDescription:
          "Mae rhai cwcis yn hanfodol er mwyn i&#8217;r wefan weithredu&#8217; gywir, fel y rhai sy&#8217;n cofio&#8217;ch datbliygad trwy ein teclynnau, neu ddefnyddio ein gwasanaeth gwe-sgwrs.",
        notifyTitle: "Dywedwch wrthym os ydych yn derbyn cwcis",
        notifyDescription:
          '<span>Rydym yn defnyddio <a href="/cy/corporate/sut-yr-ydym-yn-defnyddio-cwcis">cwcis i gasglu gwybodaeth</a> am sut rydych yn defnyddio Gwasanaeth Cynghori Ariannol.</span>' +
          "<span>Rydym yn defnyddio&#8217;r wybodaeth hon i wneud i&#8217;r wefan weithio cystal â phosibl a gwella ein gwasanaethau.</span>",
        closeLabel: "Arbed dewisiadau",
        accept: "Derbyn pob cwci",
        settings: "Gosod dewisiadau",
      },
      branding: {
        removeAbout: true,
        fontFamily:
          "'museo_sans', 'Helvetica Neue', Helvetica, Arial, sans-serif",
        fontSize: "1rem",
      },
    },
  };

  this.addOptionalCookies();
  this.addNecessaryCookies();
  this.addText();
  this.addBranding();
};

CookieController.prototype.addNecessaryCookies = function () {
  this.config.necessaryCookies = ["action-plan-*", "__zjc*", "_iz_uh_ps_", "_iz_sd_ss_"];
};

CookieController.prototype.addBranding = function () {
  var textStrings = this.textStrings[this.locale];
  var brandingObj = this.config.branding;
  var brandingContent = textStrings.branding;

  for (var content in brandingContent) {
    brandingObj[content] = brandingContent[content];
  }
};

CookieController.prototype.addText = function () {
  var textStrings = this.textStrings[this.locale];
  var textObj = this.config.text;
  var textContent = textStrings.text;

  for (var content in textContent) {
    textObj[content] = textContent[content];
  }
};

CookieController.prototype.addOptionalCookies = function () {
  var textStrings = this.textStrings[this.locale];
  var analytics = {
    name: "analytics",
    recommendedState: true,
    lawfulBasis: "legitimate interest",
    cookies: [
      "_ga",
      "_gid",
      "_gat",
      "__utma",
      "__utmt",
      "__utmb",
      "__utmc",
      "__utmz",
      "__utmv",
    ],
    label: textStrings.optionalCookies.analytics.label,
    description: textStrings.optionalCookies.analytics.description,

    onAccept: function () {
      window.dataLayer = window.dataLayer || [];

      window.dataLayer.push({
        event: "civicConsentResponse",
      });
    },

    onRevoke: function () {
      window.dataLayer = window.dataLayer || [];

      window.dataLayer.push({
        event: "civicConsentResponse",
      });
    },
  };

  this.config.optionalCookies.push(analytics);
};

CookieController.prototype.loadModule = function () {
  CookieControl.load(this.config);
};
