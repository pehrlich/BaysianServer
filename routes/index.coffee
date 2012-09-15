
#
# * GET home page.
# 
exports.index = (req, res) ->
  res.render "index",
    title: "Baysian Server in coffee2"
