#= require json2
#= require jquery
#= require spine
#= require spine/manager
#= require spine/ajax
#= require spine/route

#= require_tree ./lib
#= require_self
#= require_tree ./models
#= require_tree ./controllers
#= require_tree ./views

class App extends Spine.Controller
  constructor: ->
    super
    
    # Instantiate & append the Posts controller
    # @append(@posts = new App.Posts)
    @append(@locations = new App.Locations)

    # ...
    Spine.Route.setup()    

window.App = App
