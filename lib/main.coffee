CATALOG_URL = "/catalog.json"

fetchCatalog = ->
  $.getJSON( CATALOG_URL ).then (catalogJson)->
    the.catalog.fromJson(catalogJson)

$ ->
  conferenceModel = new the.ConferenceModel
  mainView = new the.MainView( model: conferenceModel )

  controller = the.createController({fetchCatalog:fetchCatalog,conferenceViewModel:conferenceModel})
  controller.boot()

  Backbone.history.start()
