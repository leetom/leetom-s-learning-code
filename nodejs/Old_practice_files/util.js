#!/usr/bin/env node
var util = require('util');

util.log("Sth seems wrong!");
util.debug(util.toString());
util.log(util.inspect(util, false, null));
