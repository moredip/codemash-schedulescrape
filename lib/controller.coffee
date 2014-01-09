CATALOG_URL = "/catalog.json"

createController = ({fetchCatalog,conferenceViewModel})->
  boot = ->
    fetchCatalog().then (catalog)->
      conferenceViewModel.loadTimeslotsFromCatalog(catalog.timeslots())

  {boot}

define module, 'createController',  ->
  createController
