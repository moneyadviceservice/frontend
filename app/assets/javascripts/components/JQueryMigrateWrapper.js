define(['jquerySrc', 'jquerymigrate'],
  function(jQuery, jquerymigrate) {
    'use strict';

    /**
     * Module Name: JQueryMigrateWrapper
     *
     * Description: This merges jQuery Migrate v3 with jQuery 331 and provides a jQuery 2 backwards compatible version.
     * Using this to override the 'jquery' entry in the require_config.js.erb means you no longer
     * have to update every module to load the jQueryMigrate in separately.
     *
     * In the require_config, we following these steps:
     *
     * 1. Change the jquery path to jquerySrc - this temporarily invalidates all references to 'jquery'.
     * 2. we load the jquerymigrate: requirejs_path('jquery-migrate/jquery-migrate') (as we have been).
     * 3. We load this file JQueryMigrateWrapper.js and map it to the 'jquery' path - this then provides all modules with an updated version.
     *
     * We need to make sure things are loaded in order, so we add the following to a shim block in the require_config.
     *
     *    shim: {
     * 4.   jquerymigrate: ['jquerySrc'],
     * 5.   jquery: ['jquerymigrate'],
     *      .
     *      .
     *      .
     *    }
     *
     */

    console.log('jQuery.migrateVersion', jQuery.migrateVersion, 'jQuery.fn.jquery', jQuery.fn.jquery);

    return jQuery;
  });
