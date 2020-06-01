// Karma configuration
// http://karma-runner.github.io/0.10/config/configuration-file.html

module.exports = function(config) {
  config.set({
    // base path, that will be used to resolve files and exclude
    basePath: '../../',

    // testing framework to use (jasmine/mocha/qunit/...)
    frameworks: ['requirejs', 'mocha', 'chai-jquery', 'chai', 'sinon','sinon-chai', 'fixture', 'jquery-1.12.4'],

    // list of files / patterns to load in the browser
    files: [
      'spec/javascripts/test-main.js',
      'vendor/assets/bower_components/bind-polyfill/index.js',
      'spec/javascripts/templates/*.html',
      'spec/javascripts/fixtures/*.html',
      'spec/javascripts/**/*_spec.js',
      'spec/javascripts/lib/modernizr.js',
      {pattern: 'app/assets/javascripts/**/*.js', included: false},
      {pattern: 'vendor/assets/bower_components/**/*.js', included: false},
      {pattern: 'vendor/assets/javascripts/*.js', included: false}
    ],

    client: {
      mocha: {
        ui: 'tdd'
      }
    },

    // list of files / patterns to exclude
    exclude: [],

    preprocessors: {
     '**/*.html': ['html2js'],
     'app/assets/javascripts/pensions_calculator/**/*.js': ['coverage']
    },

    reporters: ['spec'],

    // web server port
    port: 9876,

    colors: true,

    // level of logging
    // possible values: LOG_DISABLE || LOG_ERROR || LOG_WARN || LOG_INFO || LOG_DEBUG
    logLevel: config.LOG_INFO,


    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: false,


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
    singleRun: true,

    coverageReporter: {
     type : 'html',
     dir : 'spec/javascripts/coverage/'
   }
  });
};
