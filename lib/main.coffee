CATALOG_URL = "/catalog.json"

sessionsToViewModel = (sessions)->
  _.map sessions, (s)->
    room = s.room() || {}
    speakers = _.map( s.speakers(), (s)->s.name() ).join(", ")
    timeslot = s.timeslot()
    {
      name: s.Name
      description: s.Description
      room: room.Name
      speakers: speakers
      startTime: timeslot.startTimeForDisplay()
      endTime: timeslot.endTimeForDisplay()
      link: the.router.routeFor.session(s.ID)
    }

timeslotsToViewModel = (timeslots)->
  _.map timeslots, (t)->
    {
      description: t.Description
      sessions: sessionsToViewModel( t.sessions() )
    }

$ ->

  mainModel = new Backbone.Model()
  mainView = new the.MainView( model: mainModel )

  $.getJSON( CATALOG_URL ).then (catalogJson)->
    catalog = the.catalog.fromJson(catalogJson)

    mainModel.set('timeslots', timeslotsToViewModel(catalog.timeslots()))
    mainView.render()

  Backbone.history.start()
