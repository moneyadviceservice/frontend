$(function(window, $, Routes, locale) {
  'use strict';

  var loadSyndicatedProfile = function loadSyndicatedProfile() {
    $('.syndicated-profile').load(Routes.syndication_header_profile_path(locale, {tool_id: tool_id }));
  };

  $(window.document).on('signed_in.mas', loadSyndicatedProfile);

}(this, jQuery, Routes, locale));
