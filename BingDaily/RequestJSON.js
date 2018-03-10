#!/usr/bin/env node

var argv = require('yargs')
.string('r')
.string('k')
.alias('r', 'res')
.alias('h', 'help')
.option('r', {
  demand: false
})
.option('k', {
      alias : 'key',
      type: 'string', /* array | boolean | string */
      nargs: 3,
      demand: true,
      demand: 'file is required',
      // also: count:true, requiresArg:true
  })

.help('h')
.argv;
var fs = require('fs');
var Unsplash = require('fetch-everywhere').default;
var Unsplash = require('unsplash-js').default;
var toJson = require('unsplash-js').toJson;

const unsplash = new Unsplash({
  applicationId: argv.k[0],
  secret: argv.k[1],
  callbackUrl: argv.k[2]
});

var query_path = require('os').homedir() + "/.hammerspoon/BingDaily/JSONrequested.txt";
var rand_path = require('os').homedir() + "/.hammerspoon/BingDaily/JSONrequestedRand.txt";
var info_path = require('os').homedir() + "/.hammerspoon/BingDaily/info.txt";
//var res = "sun"
if (argv.r.length > 0) {

unsplash.photos.getRandomPhoto({ query: argv.r,h:800,w:1200 })
  .then(toJson)
  .then(json => {



fs.writeFileSync(query_path, JSON.stringify(json.urls.regular,null, 2) );
fs.writeFileSync(info_path, JSON.stringify(json.description,null, 2) );
console.log(json.urls)

});
}

unsplash.photos.getRandomPhoto({h:800,w:1200})
  .then(toJson)
  .then(json => {
    fs.writeFileSync(rand_path, JSON.stringify(json.urls.regular,null, 2) );
    fs.writeFileSync(info_path, JSON.stringify(json.description,null, 2) );
    console.log(json.urls.regular)

  });
