presentSessionsFromCatalog = (sessions)->
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

# map the representation of a timeslot in 
# the catalog to a view-model representation
presentTimeslotFromCatalog = (timeslot)->
  {
    description: timeslot.Description
    sessions: presentSessionsFromCatalog( timeslot.sessions() )
  }


TimeslotModel = Backbone.Model.extend
  defaults:
    collapsed: true

  toggleCollapsed: ->
    @set( 'collapsed', !@get('collapsed') )


TimeslotsCollection = Backbone.Collection.extend
  model: TimeslotModel

ConferenceModel = Backbone.Model.extend
  defaults:  ->
    timeslots: new TimeslotsCollection

  loadTimeslotsFromCatalog: (timeslots)->
    timeslotsAsViewModels = _.map( timeslots, presentTimeslotFromCatalog )
    @get('timeslots').add( timeslotsAsViewModels )

  expandAllTimeslots: ->
    @get('timeslots').invoke( 'set', {collapsed: false} )

#define module, 'TimeslotModel', TimeslotModel
#define module, 'TimeslotsCollection', TimeslotsCollection
define module, 'ConferenceModel', -> ConferenceModel
