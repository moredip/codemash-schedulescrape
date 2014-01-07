define module, 'router', ->
  OurRouter = Backbone.Router.extend 
    routes:
      '' : 'home',
      'session/:id': 'session'

    home: ->

    session: (id)->
      console.log("details for session #{id}")

    routeFor: 
      session: (id)-> "#session/#{id}" 

  new OurRouter
