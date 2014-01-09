createController = ({fetchCatalog,conferenceViewModel})->
  boot = ->
    fetchCatalog().then (catalog)->
      conferenceViewModel.loadTimeslotsFromCatalog(catalog.timeslots())

  {boot}

define module, 'createController',  ->
  createController
