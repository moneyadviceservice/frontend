//= require require_config

require(["common", "jquery"], function (MAS, $) {
  "use strict";

  if (MAS.fonts.loadWithJS && MAS.fonts.url && !MAS.fonts.localstorage) {
    require(["jquery", "common"], function ($, MAS) {
      MAS.log("FONTS: load via ajax");
      $.ajax({
        url: MAS.fonts.url,
        success: function (res) {
          MAS.log(
            "FONTS: ajax load success > stylesheet appended to page > load class added"
          );
          $("html").addClass(MAS.fonts.loadClass);
          $("head").append("<style>" + res + "</style>");
          if (MAS.supports.localstorage) {
            MAS.log("FONTS: localstorage supported, fonts saved");
            localStorage.setItem(MAS.fonts.cacheName, res);
          }
        },
        dataType: "text",
      });
    });
  }

  if (window.enableScrollTracking) {
    require(["jquery", "scrollTracking"], function ($, scrollTracking) {
      // Analytics scroll tracking on editorial pages
      scrollTracking({
        el: ".editorial",
        triggerPoints: [0.25, 0.5, 0.75, 1],
      });
    });
  }

  require(["jquery", "collapsable"], function ($, Collapsable) {
    $(document).ready(function () {
      // Mobile Search Button
      new Collapsable({
        name: "mobileSearch",
        closeOffFocus: false,
        accordion: true,
        triggerEl: ".mobile-nav__link--search",
        targetType: "href",
        hideByDefault: true,
      });

      // Article Collapsables
      new Collapsable({
        name: "articleCollapsables",
        showOnlyFirst: true,
        showIcon: true,
        useButton: true,
      });

      // Category Collapsables
      new Collapsable({
        name: "categoryCollapsables",
        triggerEl: ".js-category-detail__toggle-view",
        targetEl: ".js-category-detail__list--extended",
      });

      // Debt Campaign Companies affected
      new Collapsable({
        name: "companiesAffected",
        showIcon: true,
        useButton: true,
        triggerEl: ".l-debtmanagement__companies-heading",
        targetEl: ".l-debtmanagement__companies-list",
      });

      if ($(this).width() <= 720) {
        new Collapsable({
          name: "contactCollapsables",
          showIcon: true,
          useButton: true,
          triggerEl: ".contact-detail__heading",
          targetEl: ".contact-detail__content",
        });
      }
    });
  });

  require(["jquery", "ujs"], function ($) {
    $(document).ready(function () {
      // Cookie message
      $(".js-cookie-message").on("ajax:success", function () {
        $(".cookie-message").hide();
        $(".footer-site-links__cookie-link").removeClass("is-on");
      });
    });
  });

  // Cookie controller
  // Implementation of the Cookie Control module from Civic
  // Documentation: https://www.civicuk.com/cookie-control/documentation
  require(["jquery", "cookieController"], function($, cookieController) {
    $(document).ready(function() {
      var cookieControllerModule = new cookieController({
        apiKey: '592b99ebdf88c091dad9b556b6d8de236ac97687', 
        product: 'PRO_MULTISITE', 
        mode: 'GDPR',
        consentCookieExpiry: '360',
        initialState: 'notify',
        rejectButton: false,
        layout: 'slideout',
        position: 'left',
        setInnerHTML: true,
        notifyDismissButton: false,
        closeOnGlobalChange: true,
        closeStyle: 'button',
        subDomains: true
      });

      cookieControllerModule.loadModule(); 
    });
  });

  // Kick off component loader
  var engines = [];
  $("[data-engine]").each(function () {
    engines.push($(this).attr("data-engine") + "Config");
  });

  require(engines, function () {
    require(["componentLoader", "eventsWithPromises"], function (
      componentLoader,
      eventsWithPromises
    ) {
      componentLoader.init($("body"));
      eventsWithPromises.subscribe("component:contentChange", function (data) {
        componentLoader.init(data.$container);
      });
    });
  });
});
