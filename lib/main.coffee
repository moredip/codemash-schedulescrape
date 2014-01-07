CATALOG_URL = "/catalog.json"


timeslotsToViewModel = (timeslots)->
  _.map timeslots, (t)->
    {
      description: t.Description
    }

$ ->

  mainModel = new Backbone.Model()
  mainView = new the.MainView( model: mainModel )

  $.getJSON( CATALOG_URL ).then (catalogJson)->
    catalog = the.catalog.fromJson(catalogJson)
    console.dir(catalog)

    mainModel.set('timeslots', timeslotsToViewModel(catalog.timeslots()))
    mainView.render()

  new the.router

  Backbone.history.start()
