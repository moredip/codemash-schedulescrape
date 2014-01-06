fromJson = (json)-> 
  timeslotById = (id)->
    idAsNumber = parseInt(id)
    _.findWhere( json.Timeslots, {"ID":idAsNumber} )

  decoratedTimeslot = (timeslot)->
    sessions = ->
      _.where( json.Sessions, {TimeSlotID:timeslot.ID} )

    _.extend( timeslot, {sessions} )

  {
    speakers: -> json.Speakers
    timeslots: -> _.map( json.Timeslots, decoratedTimeslot )
    timeslotById: timeslotById
  }

define module, 'catalog',  ->
  { fromJson }
