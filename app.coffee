
###
Module dependencies.
###
express = require("express")

# todo: this is dumb?
# http://elegantcode.com/2012/01/20/taking-toddler-steps-with-node-js-express-routing/
routes = require("./routes")
user = require("./routes/user")
classifier = require("./routes/classifier")

http = require("http")
path = require("path")
app = express()

# alternative for coffeescript?
#app.use express.compiler(src: __dirname + "/../public", enable: ["coffeescript"])


app.configure ->
  app.set "port", process.env.PORT or 3000
  app.set "views", __dirname + "/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use require("stylus").middleware(__dirname + "/public")
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()





app.get "/", routes.index
app.get "/users", user.list
app.get "/classifier/:id", classifier.serialize

app.post "/classifier/:id/train", classifier.train



http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port #{app.get("port")}"
