#!/usr/bin/env node
var fs = require('fs');

var argv = require('yargs')
.string('lon')
.string('lat')

.option('lon', {
      alias : 'lon',
      type: 'string', /* array | boolean | string */
      nargs: 1,
      demand: true,
      demand: 'loc is required',
      // also: count:true, requiresArg:true
  })
.option('lat', {
        alias : 'lat',
        type: 'string', /* array | boolean | string */
        nargs: 1,
        demand: true,
        demand: 'lat is required',
        // also: count:true, requiresArg:true
    })
.option('k', {
      alias : 'key',
      type: 'string', /* array | boolean | string */
      nargs: 3,
      demand: true,
      demand: 'auth is required',
      // also: count:true, requiresArg:true
  })

.help('h')
.argv;

var OAuth = require('oauth');
var header = {
    "X-Yahoo-App-Id": argv.k[0]
};
var request = new OAuth.OAuth(
    null,
    null,
    argv.k[1],
    argv.k[2],
    '1.0',
    null,
    'HMAC-SHA1',
    null,
    header
);

var lat=argv.lat
var lon=argv.lon
var path = require('os').homedir() + "/.hammerspoon/hs-weather/query.txt";

var query='https://weather-ydn-yql.media.yahoo.com/forecastrss?lat='+argv.lat+'&lon='+argv.lon+'&u=c&format=json'
request.get(
    query,
    null,
    null,
    function (err, data, result) {
        if (err) {
            console.log(err);
        } else {
          fs.writeFileSync(path, data );
        }
    }
);
