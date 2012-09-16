classifier_lib = require('classifier')

###
When using Heroku, we must split up the URL in to its various parts to be connected via classifier
Other solutions:
- amend classifier to take a redis client directly, a la https://devcenter.heroku.com/articles/nodejs#using-redis https://github.com/cmanzana/heroku-redis-client
- amend redis to take a URL
http://blog.jerodsanto.net/2011/06/connecting-node-js-to-redis-to-go-on-heroku/
###

#redis://redistogo:c83b31be10732edd570946a8c627d572@barb.redistogo.com:9762/
exports.bayes = if (url = process.env['REDISTOGO_URL'])
  redis_url = require("url").parse(url)
  new classifier_lib.Bayesian({
    backend: {
       type: 'Redis',
       options: {
         hostname: redis_url.hostname,
         port: redis_url.port,
         password: redis_url.auth.split(":")[1],
         name: 'classifier'
       }
    }
  })
else
  new classifier_lib.Bayesian({
    backend: {
       type: 'Redis',
       options: {
         name: 'classifier'
       }
    }
  })


