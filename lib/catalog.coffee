deserializeDateTime = (dateStr)->
  timestampStr = dateStr.match(/\/Date\((\d*)\)\//)[1]
  new Date( parseInt(timestampStr) )

convertSerializedTimeToDisplayableTime = (dateStr)->
  return "" unless dateStr?

  date = deserializeDateTime( dateStr )
  "#{date.getUTCHours()}:#{date.getUTCMinutes()}"

fromJson = (json)-> 
  createEntityByIdFn = (entityName, decoratorFn = _.identity )->
    (id)->
      idAsNumber = parseInt(id)
      decoratorFn( _.findWhere( json[entityName], {ID:idAsNumber} ) )


  speakersForSessionId = (sessionId)->
    speakerSessionPairs = _.where( json.SessionSpeakers, {SessionID:sessionId} )
    _.map speakerSessionPairs, (pair)-> 
      speakerById( pair.SpeakerID )


  decorateTimeslot = (timeslot)->
    return unless timeslot?
    sessions = ->
      _.map( _.where( json.Sessions, {TimeSlotID:timeslot.ID} ), decorateSession )
    startTimeForDisplay = -> convertSerializedTimeToDisplayableTime(timeslot.StartTime)
    endTimeForDisplay = -> convertSerializedTimeToDisplayableTime(timeslot.EndTime)

    _.extend( timeslot, {sessions,startTimeForDisplay,endTimeForDisplay} )

  decorateSession = (session)->
    return unless session?
    room = -> roomById( session.LocationID )
    speakers = -> speakersForSessionId( session.ID )
    timeslot = -> timeslotById( session.TimeSlotID )
    _.extend( session, {room,speakers,timeslot} )

  decorateSpeaker = (speaker)->
    return unless speaker?
    name = -> "#{speaker.FirstName} #{speaker.LastName}"
    _.extend( speaker, {name} )

  timeslotById = createEntityByIdFn('Timeslots', decorateTimeslot)
  sessionById = createEntityByIdFn('Sessions', decorateSession)
  roomById = createEntityByIdFn('Rooms')
  speakerById = createEntityByIdFn('Speakers', decorateSpeaker)

  {
    speakers: -> json.Speakers
    timeslots: -> _.map( json.Timeslots, decorateTimeslot )
    timeslotById: timeslotById
    sessionById: sessionById
    roomById: roomById
    speakerById: speakerById
  }

define module, 'catalog',  ->
  { fromJson }
