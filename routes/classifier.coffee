
bayes = require('../config').bayes

exports.serialize = (req, res) ->
  bayes.toJSON ()->
    res.send arguments


exports.train = (req, res)->
  console.dir req.body
  unless cat = req.body.cat
    res.send "no category ok"
    return
  unless doc = req.body.doc
    res.send "no doc (words)"
    return

  bayes.train(doc, cat)