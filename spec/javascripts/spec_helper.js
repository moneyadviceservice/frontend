//= require_tree ./templates
//= require sinonjs/sinon
//= require in_head
//= require requirejs/require
//= require jquery
//= require require_config

var expect = chai.expect;

// There is a problem abstracting console.log to MAS.log - this prevents it from blocking the test
// Might be that .log is not in the scope of window when run in CL
var log = function(o){ console.log(o) };
MAS.log = MAS.info = MAS.warn = log;
