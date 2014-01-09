Backbone = require('backbone')
Q = require('q')

createController = require('../lib/controller')

describe 'the main controller', ->

  describe 'boot', ->
    genericConferenceViewModel = {
      loadTimeslotsFromCatalog: _.identity
    }
    genericPromise = Q("blah")

    createIsolatedController = (explicitDependencies = {})->
      defaultDeps = {
        fetchCatalog: -> genericPromise
        conferenceViewModel: genericConferenceViewModel
      }

      createController( _.extend( {}, defaultDeps, explicitDependencies ) )


    it 'requests the catalog from the catalog source', ->
      spyCatalogSource = sinon.stub().returns(genericPromise)
      
      controller = createIsolatedController( fetchCatalog: spyCatalogSource )
      controller.boot()

      expect( spyCatalogSource ).called

    it 'updates its conference view model with timeslots from the fetched catalog', (done)->
      fakeCatalog = {
        timeslots: -> 'timeslots from fake catalog'
      }
      
      fakeCatalogFetch = Q(fakeCatalog)
      stubCatalogSource = -> fakeCatalogFetch

      spyConferenceModel = {
        loadTimeslotsFromCatalog: sinon.spy()
      }

      controller = createIsolatedController( fetchCatalog: stubCatalogSource, conferenceViewModel: spyConferenceModel )
      controller.boot().then ->
        expect( spyConferenceModel.loadTimeslotsFromCatalog ).calledWith( 'timeslots from fake catalog' )
        done()
