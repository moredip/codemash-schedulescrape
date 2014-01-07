
fromJson = (json)-> 
  createEntityByIdFn = (entityName, decoratorFn = _.identity )->
    (id)->
      idAsNumber = parseInt(id)
      decoratorFn( _.findWhere( json[entityName], {"ID":idAsNumber} ) )


  decorateTimeslot = (timeslot)->
    return unless timeslot?
    sessions = ->
      _.where( json.Sessions, {TimeSlotID:timeslot.ID} )

    _.extend( timeslot, {sessions} )

  decorateSession = (session)->
    return unless session?
    room = -> roomById( session.LocationID )
    _.extend( session, {room} )

  timeslotById = createEntityByIdFn('Timeslots', decorateTimeslot)
  sessionById = createEntityByIdFn('Sessions', decorateSession)
  roomById = createEntityByIdFn('Rooms')

  {
    speakers: -> json.Speakers
    timeslots: -> _.map( json.Timeslots, decorateTimeslot )
    timeslotById: timeslotById
    sessionById: sessionById
    roomById: roomById
  }

define module, 'catalog',  ->
  { fromJson }
