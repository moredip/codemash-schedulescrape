CATALOG_URL = "/catalog.json"

createController = ({jsonFetcher,catalogCreator,timeslotsViewModelMapper,mainModel})->
  boot = ->
    jsonFetcher(CATALOG_URL).then (json)->
      catalog = catalogCreator(json)
      viewModel = timeslotsViewModelMapper( catalog.timeslots() )
      mainModel.set('timeslots',viewModel)



  {boot}

define module, 'createController',  ->
  createController
