// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '..',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['requirejs', 'mocha', 'sinon-chai'],

    // list of files / patterns to load in the browser
    files: [
      'spec/javascripts/test-main.js',
      'spec/javascripts/templates/*.html',
      'spec/javascripts/*_spec.js',
      {pattern: 'app/assets/javascripts/**/*.js', included: false},
      {pattern: 'vendor/assets/bower_components/**/*.js', included: false}
    ],

    client: {
      mocha: {
        ui: 'tdd'
      }
    },

    plugins: [
      // these plugins will be require() by Karma
      'karma-mocha',
      'karma-requirejs',
      'karma-sinon-chai',
      'karma-phantomjs-launcher',
      'karma-html2js-preprocessor'
    ],

    // list of files / patterns to exclude
    exclude: [],

    preprocessors: {
      '**/*.html': 'html2js'
    },

    reporters: ['dots'],

    // web server port
    port: 9876,

    colors: true,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,


    // Start these browsers, currently available:
    // - Chrome
    // - ChromeCanary
    // - Firefox
    // - Opera
    // - Safari (only Mac)
    // - PhantomJS
    // - IE (only Windows)
    browsers: ['PhantomJS'],

    captureTimeout: 60000,


    // Continuous Integration mode
    // if true, it capture browsers, run tests and exit
    singleRun: false
  });
};
