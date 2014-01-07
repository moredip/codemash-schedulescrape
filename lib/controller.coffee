CATALOG_URL = "/catalog.json"

createController = ({jsonFetcher,catalogCreator,timeslotsViewModelMapper})->
  boot = ->
    jsonFetcher(CATALOG_URL).then (json)->
      catalog = catalogCreator(json)
      console.log( 'TIMESLOTS: ', catalog.timeslots() )
      viewModel = timeslotsViewModelMapper( catalog.timeslots() )


  {boot}

define module, 'createController',  ->
  createController
